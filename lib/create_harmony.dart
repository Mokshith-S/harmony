import 'dart:io';

import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:harmony/widget/song_control.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as path;

class HarmonyPanel extends StatefulWidget {
  const HarmonyPanel({super.key, required this.harmonyAudio});
  final String harmonyAudio;
  @override
  State<HarmonyPanel> createState() => _HarmonyPanelState();
}

class _HarmonyPanelState extends State<HarmonyPanel> {
  final harmonySong = audio.AudioPlayer();
  final harmonyTemp = audio.AudioPlayer();
  Duration harmonyTime = const Duration();
  Duration harmonyCurrentTime = const Duration();
  // final harmonyRecorder = AudioRecorder();
  final harmonyRecorder = FlutterSoundRecorder();
  // RecordState? harmonyRecordState;
  late final Directory recordPath;

  void audioInitializer() async {
    await harmonySong.setSource(audio.DeviceFileSource(widget.harmonyAudio));

    harmonySong.setReleaseMode(audio.ReleaseMode.stop);

    harmonySong.onDurationChanged.listen((Duration d) {
      harmonyTime = d;
    });

    harmonySong.onPlayerStateChanged.listen((audio.PlayerState state) {
      if (mounted) {
        setState(() {});
      }
    });

    harmonySong.onPositionChanged.listen((Duration d) {
      setState(() {
        harmonyCurrentTime = d;
      });
    });
  }

  void recordInitializer() async {
    final status = await Permission.microphone.request();

    if (status == PermissionStatus.granted) {
      Directory recordDirectory = await path.getApplicationDocumentsDirectory();
      recordPath = await Directory('${recordDirectory.path}/record').create();

      await harmonyRecorder.openRecorder();
    }
  }

  @override
  void initState() {
    audioInitializer();
    recordInitializer();
    super.initState();
  }

  @override
  void dispose() {
    harmonySong.setReleaseMode(audio.ReleaseMode.release);
    harmonySong.dispose();
    harmonyTemp.dispose();
    harmonyRecorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harmony'),
        backgroundColor: const Color.fromARGB(255, 145, 56, 229),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: LinearProgressIndicator(
              backgroundColor: const Color.fromARGB(255, 198, 198, 198),
              color: const Color.fromARGB(255, 145, 56, 229),
              minHeight: 10.0,
              value: harmonyTime.inSeconds != 0
                  ? harmonyCurrentTime.inSeconds / harmonyTime.inSeconds
                  : 0.0,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SongControl(
                icon: harmonySong.state == audio.PlayerState.playing
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                controlLogic: harmonySong.state == audio.PlayerState.playing
                    ? () {
                        harmonySong.pause();
                      }
                    : () {
                        harmonySong.resume();
                      },
                color: const Color.fromARGB(255, 108, 42, 170),
                splash: false,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () async {
                  String? path = await harmonyRecorder.stopRecorder();
                  print(path);
                  if (path != null) {
                    await harmonyTemp.play(audio.DeviceFileSource(path));
                  }
                },
                child: Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  width: 60,
                  child: const Icon(
                    Icons.mic_none_rounded,
                    size: 30,
                    color: Color.fromARGB(255, 108, 42, 170),
                  ),
                ),
              ),
              SongControl(
                icon: harmonyRecorder.isPaused
                    ? Icons.stop
                    : Icons.mic_none_rounded,
                controlLogic: () async {
                  if (harmonyRecorder.isRecording) {
                    print('Recording paused');
                    await harmonyRecorder.pauseRecorder();
                  } else {
                    if (harmonyRecorder.isPaused) {
                      print('Recording resume');
                      await harmonyRecorder.resumeRecorder();
                    } else {
                      print('Recording started');
                      await harmonyRecorder.startRecorder(
                          toFile: recordPath.path);
                    }
                  }
                },
                color: const Color.fromARGB(255, 108, 42, 170),
                splash: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

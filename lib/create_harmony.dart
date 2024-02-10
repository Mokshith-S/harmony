import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmony/widget/song_control.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as path;

class HarmonyPanel extends StatefulWidget {
  const HarmonyPanel({super.key, required this.harmonyAudio});
  final String harmonyAudio;
  @override
  State<HarmonyPanel> createState() => _HarmonyPanelState();
}

class _HarmonyPanelState extends State<HarmonyPanel>
    with SingleTickerProviderStateMixin {
  final harmonySong = audio.AudioPlayer();
  Duration harmonyTime = const Duration();
  Duration harmonyCurrentTime = const Duration();
  final harmonyRecorder = FlutterSoundRecorder();
  late final Directory recordPath;
  bool stopRecordButtonState = false;
  late AnimationController stopRecordButtonAnimation;
  bool recording = true;
  Color? color;

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
    stopRecordButtonAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    harmonySong.setReleaseMode(audio.ReleaseMode.release);
    harmonySong.dispose();
    harmonyRecorder.closeRecorder();
    stopRecordButtonAnimation.dispose();
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
            child: ProgressBar(
              progress: harmonyCurrentTime,
              total: harmonyTime,
              onSeek: (value) {
                harmonySong.seek(value);
              },
              barHeight: 10.0,
              baseBarColor: const Color.fromARGB(255, 198, 198, 198),
              progressBarColor: const Color.fromARGB(255, 145, 56, 229),
              thumbColor: const Color.fromARGB(255, 145, 56, 229),
              thumbGlowRadius: 20.0,
              timeLabelPadding: 4.0,
              timeLabelTextStyle: GoogleFonts.baloo2(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
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
              GestureDetector(
                onTap: recording
                    ? () async {
                        stopRecordButtonAnimation.reset();
                        setState(() {
                          color = const Color.fromARGB(255, 213, 211, 215);
                        });
                        stopRecordButtonAnimation.forward();

                        if (harmonyRecorder.isRecording) {
                          await harmonyRecorder.pauseRecorder();
                        } else {
                          if (harmonyRecorder.isPaused) {
                            await harmonyRecorder.resumeRecorder();
                          } else {
                            await harmonyRecorder.startRecorder(
                                toFile: '${recordPath.path}/audio_record');
                          }
                        }
                        setState(() {});
                      }
                    : () {
                        stopRecordButtonAnimation.reset();
                        setState(() {
                          color = const Color.fromARGB(255, 213, 211, 215);
                        });
                        stopRecordButtonAnimation.forward();
                      },
                onLongPress: harmonyRecorder.isPaused
                    ? () async {
                        if (!harmonyRecorder.isStopped) {
                          setState(() {
                            color = const Color.fromARGB(255, 213, 211, 215);

                            stopRecordButtonAnimation.repeat(reverse: true);
                            stopRecordButtonState = true;
                          });
                          await harmonyRecorder.stopRecorder();
                          // Recording is stopped here
                          Future.delayed(const Duration(milliseconds: 500), () {
                            setState(() {
                              color = null;
                              stopRecordButtonAnimation.reset();
                              recording = false;
                            });
                          });
                        }
                      }
                    : null,
                child: Stack(alignment: Alignment.center, children: [
                  FadeTransition(
                    opacity: Tween<double>(begin: 1, end: 0).animate(
                      CurvedAnimation(
                          parent: stopRecordButtonAnimation,
                          curve: Curves.easeIn),
                    ),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                    ),
                  ),
                  Icon(
                    stopRecordButtonState
                        ? Icons.mic_off_rounded
                        : harmonyRecorder.isPaused
                            ? Icons.stop
                            : Icons.mic_none_rounded,
                    size: 30,
                    color: const Color.fromARGB(255, 108, 42, 170),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

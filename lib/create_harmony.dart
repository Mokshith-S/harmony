import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmony/widget/song_control.dart';

class HarmonyPanel extends StatefulWidget {
  const HarmonyPanel({super.key, required this.harmonyPath});
  final String harmonyPath;
  @override
  State<HarmonyPanel> createState() => _HarmonyPanelState();
}

class _HarmonyPanelState extends State<HarmonyPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harmony'),
        backgroundColor: const Color.fromARGB(255, 145, 56, 229),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // const SizedBox(
            //   height: 400,
            // ),
            Text(
              'Music',
              style: GoogleFonts.dmSerifText(
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SongControl(
              icon: Icons.play_arrow_rounded,
              controlLogic: () {},
              color: const Color.fromARGB(255, 108, 42, 170),
              splash: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Audio',
              style: GoogleFonts.dmSerifText(
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SongControl(
              icon: Icons.mic_none_rounded,
              controlLogic: () {},
              color: const Color.fromARGB(255, 108, 42, 170),
              splash: true,
            ),
          ],
        ),
      ),
    );
  }
}

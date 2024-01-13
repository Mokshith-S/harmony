import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/bloc/harmony_bloc.dart';
import 'package:harmony/bloc/harmony_event.dart';
import 'package:harmony/bloc/harmony_state.dart';

import 'package:harmony/widget/song_control.dart';
import 'package:harmony/widget/songwave.dart';

class SongTile extends StatelessWidget {
  const SongTile({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color.fromARGB(255, 255, 146, 9),
      ),
      child: BlocBuilder<HarmonyBloc, HarmonyState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Song-$index',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 8,
              ),
              SongWave(waveRunning: false, harmonyId: 'Creation-$index'),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SongControl(
                      icon: Icons.fast_rewind_rounded, controlLogic: () {}),
                  SongControl(
                      icon: state is PlayState &&
                              state.harmonyId == 'Creation-$index'
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      controlLogic: state is PlayState
                          ? () {
                              context
                                  .read<HarmonyBloc>()
                                  .add(StopEvent('Creation-$index'));
                            }
                          : () {
                              context
                                  .read<HarmonyBloc>()
                                  .add(PlayEvent('Creation-$index'));
                            }),
                  SongControl(
                      icon: Icons.fast_rewind_rounded, controlLogic: () {}),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

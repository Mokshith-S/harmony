import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/bloc/harmony_bloc.dart';
import 'package:harmony/bloc/harmony_state.dart';

class SongWave extends StatelessWidget {
  const SongWave(
      {super.key, required this.waveRunning, required this.harmonyId});
  final bool waveRunning;
  final String harmonyId;

  @override
  Widget build(BuildContext context) {
    List<int> duration = [600, 500, 800, 900, 1200];
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            15,
            (index) => SingleWaveAnimation(
                  harmonyId: harmonyId,
                  duration: duration[index % 5],
                )),
      ),
    );
  }
}

class SingleWaveAnimation extends StatefulWidget {
  const SingleWaveAnimation(
      {super.key, required this.duration, required this.harmonyId});
  final String harmonyId;
  final int duration;

  @override
  State<SingleWaveAnimation> createState() => _SingleWaveAnimationState();
}

class _SingleWaveAnimationState extends State<SingleWaveAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _control;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _control = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _animation = Tween(begin: 5.0, end: 30.0)
        .animate(CurvedAnimation(parent: _control, curve: Curves.easeInCubic))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HarmonyBloc, HarmonyState>(
      listener: (context, state) {
        if (state is PlayState) {
          if (state.harmonyId == widget.harmonyId) {
            _control.repeat(reverse: true);
          }
        } else if (state is StopState) {
          if (state.harmonyId == widget.harmonyId) {
            _control.reset();
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 4, right: 4),
        width: 8,
        height: _animation.value,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}

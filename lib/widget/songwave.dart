import 'package:flutter/material.dart';

class SongWave extends StatelessWidget {
  const SongWave({
    super.key,
    required this.waveRunning,
  });

  final bool waveRunning;

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
                  singleWaveState: waveRunning,
                  duration: duration[index % 5],
                )),
      ),
    );
  }
}

class SingleWaveAnimation extends StatefulWidget {
  const SingleWaveAnimation({
    super.key,
    required this.singleWaveState,
    required this.duration,
  });
  final int duration;
  final bool singleWaveState;

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
        .animate(CurvedAnimation(parent: _control, curve: Curves.easeInCubic));
    // ..addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    _control.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.singleWaveState && !_control.isAnimating) {
      _control.repeat(reverse: true);
    } else {
      _control.reset();
    }
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      width: 8,
      height: _animation.value,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.white,
      ),
    );
  }
}

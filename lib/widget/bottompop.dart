import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/bloc/harmony_bloc.dart';
import 'package:harmony/bloc/harmony_state.dart';
import 'package:harmony/widget/painting.dart';

class BottomLivePopUp extends StatefulWidget {
  const BottomLivePopUp({super.key});

  @override
  State<BottomLivePopUp> createState() => _BottomLivePopUpState();
}

class _BottomLivePopUpState extends State<BottomLivePopUp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _control;
  late final Animation _animationControl;

  @override
  void initState() {
    super.initState();
    _control = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animationControl = Tween(begin: 0.0, end: 74.0)
        .animate(CurvedAnimation(parent: _control, curve: Curves.easeIn));
    // _control.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _control.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HarmonyBloc, HarmonyState>(
      listener: (context, state) {
        if (state is PlayState) {
          _control.forward();
        } else {
          _control.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: _animationControl,
        builder: (context, child) => FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(_control),
          child: CustomPaint(
            painter: BottomLivePaint(),
            size: Size(double.infinity, _animationControl.value),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SongControl extends StatelessWidget {
  const SongControl(
      {super.key,
      required this.icon,
      required this.controlLogic,
      this.color = Colors.black,
      this.splash = false});

  final IconData icon;
  final void Function() controlLogic;
  final Color color;
  final bool splash;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: controlLogic,
      icon: Icon(icon),
      iconSize: 30,
      color: color,
      splashColor: splash ? Colors.red : null,
      splashRadius: splash ? 30 : null,
    );
  }
}

import 'package:flutter/material.dart';

class SongControl extends StatelessWidget {
  const SongControl(
      {super.key, required this.icon, required this.controlLogic});

  final IconData icon;
  final void Function() controlLogic;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: controlLogic,
      icon: Icon(icon),
      iconSize: 30,
    );
  }
}

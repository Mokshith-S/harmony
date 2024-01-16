import 'package:flutter/material.dart';

class SongControl extends StatelessWidget {
  const SongControl(
      {super.key,
      required this.icon,
      this.iconSelected,
      required this.controlLogic,
      this.selected = false,
      this.color = Colors.black,
      this.splash = false});

  final IconData icon;
  final void Function() controlLogic;
  final Color color;
  final bool splash;
  final bool selected;
  final IconData? iconSelected;

  @override
  Widget build(BuildContext context) {
    print(iconSelected);
    print(selected);
    return IconButton(
      onPressed: controlLogic,
      icon: Icon(icon),
      iconSize: 30,
      color: color,
      splashColor: splash ? Colors.red : null,
      splashRadius: splash ? 30 : null,
      isSelected: selected,
      selectedIcon: iconSelected == null ? null : Icon(iconSelected),
    );
  }
}

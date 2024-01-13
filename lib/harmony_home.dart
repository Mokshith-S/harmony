import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/bloc/harmony_bloc.dart';
import 'package:harmony/bloc/harmony_state.dart';
import 'package:harmony/widget/bottompop.dart';
import 'package:harmony/widget/song_tile.dart';

class HarmonyHome extends StatefulWidget {
  const HarmonyHome({super.key});

  @override
  State<HarmonyHome> createState() => _HarmonyHomeState();
}

class _HarmonyHomeState extends State<HarmonyHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController floatIcon;
  bool pressed = false;
  late final AnimationController control;

  @override
  void initState() {
    control = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(217, 145, 56, 229),
                Color.fromARGB(255, 138, 43, 226),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              image: DecorationImage(
                image: AssetImage(
                  'assets/notelarge.png',
                ),
                colorFilter: ColorFilter.mode(
                  Color.fromARGB(170, 203, 199, 199),
                  BlendMode.srcIn,
                ),
                // opacity: 0.5,
              ),
            ),
            child: SafeArea(
              child: BlocBuilder<HarmonyBloc, HarmonyState>(
                builder: (context, state) {
                  final EdgeInsets padding;
                  if (state is PlayState) {
                    padding = const EdgeInsets.fromLTRB(10, 10, 10, 84);
                  } else {
                    padding = const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10);
                  }
                  return ListView.builder(
                    padding: padding,
                    itemCount: 10,
                    itemBuilder: (context, index) => SongTile(index: index),
                  );
                },
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomLivePopUp(),
          ),
          Positioned(
            bottom: 40,
            right: 25,
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                height: pressed ? 160 : 60,
                alignment: Alignment.bottomCenter,
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  alignment:
                      pressed ? Alignment.topCenter : Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed('temp'),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.folder,
                        size: 30,
                        color: Color.fromARGB(217, 145, 56, 229),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
                child: BlocBuilder<HarmonyBloc, HarmonyState>(
                  builder: (context, state) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: state is HarmonyInitial
                              ? []
                              : [
                                  const BoxShadow(
                                      color: Color.fromARGB(255, 59, 53, 216),
                                      spreadRadius: 4,
                                      blurRadius: 10)
                                ]),
                      child: AnimatedSwitcher(
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        duration: const Duration(milliseconds: 200),
                        child: !pressed
                            ? const Icon(
                                key: ValueKey(1),
                                Icons.add,
                                size: 50,
                                color: Color.fromARGB(217, 145, 56, 229),
                              )
                            : const Icon(
                                key: ValueKey(2),
                                Icons.close_sharp,
                                size: 50,
                                color: Color.fromARGB(217, 145, 56, 229),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

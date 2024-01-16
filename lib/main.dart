import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/bloc/harmony_bloc.dart';
import 'package:harmony/create_harmony.dart';
import 'package:harmony/harmony_home.dart';

void main() {
  runApp(const HarmonyController());
}

class HarmonyController extends StatelessWidget {
  const HarmonyController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HarmonyBloc(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const HarmonyHome(),
          'control_panel': (context) => const HarmonyPanel(),
        },
      ),
    );
  }
}

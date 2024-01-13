import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/bloc/harmony_bloc.dart';
import 'package:harmony/harmony_home.dart';
import 'package:harmony/new_page.dart';

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
          'temp': (context) => const TempRoute(),
        },
      ),
    );
  }
}

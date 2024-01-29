import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/bloc/harmony_bloc.dart';

import 'package:harmony/route/harmony_route.dart';

void main() {
  runApp(const HarmonyController());
}

class HarmonyController extends StatelessWidget {
  const HarmonyController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HarmonyBloc(),
      child: const MaterialApp(
        initialRoute: '/',
        onGenerateRoute: HarmonyRoute.generateRoute,
      ),
    );
  }
}

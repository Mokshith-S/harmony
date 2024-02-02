import 'package:flutter/material.dart';
import 'package:harmony/create_harmony.dart';
import 'package:harmony/harmony_home.dart';

class HarmonyRoute {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    final args = setting.arguments;

    switch (setting.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HarmonyHome());
      case 'control_panel':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => HarmonyPanel(harmonyAudio: args));
        }
        return errorRoute();
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Invalid Page'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/');
                      },
                      child: const Text('Press')),
                ]),
          ),
        ),
      ),
    );
  }
}

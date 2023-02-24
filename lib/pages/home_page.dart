import 'package:flutter/material.dart';
import 'package:flutter_bonfire_first/screen/game_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) {
                    return const BonfireGameExample();
                  },
                ), (route) => false);
              },
              child: const Text('시작하기'))),
    );
  }
}

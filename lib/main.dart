import 'package:flutter/material.dart';
import 'package:flutter_bonfire_first/pages/home_page.dart';

import 'controller/fade_page_transition.dart';
import 'screen/game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          pageTransitionsTheme: PageTransitionsTheme(
              builders: {TargetPlatform.android: FadePageTransition()})),
      home: const HomePage(),
    );
  }
}

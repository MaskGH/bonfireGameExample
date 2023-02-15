import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

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
      ),
      home: const BonfireGameExample(),
    );
  }
}

class BonfireGameExample extends StatefulWidget {
  const BonfireGameExample({super.key});

  @override
  State<BonfireGameExample> createState() => _BonfireGameExampleState();
}

class _BonfireGameExampleState extends State<BonfireGameExample> {
  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      joystick: Joystick(directional: JoystickDirectional()),
      map: WorldMapByTiled('1.json', forceTileSize: Vector2(20, 20)),
      player: Ninja(
        Vector2(40, 40),
      ),
    );
  }
}

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
      'idle.png',
      SpriteAnimationData.sequenced(
          amount: 11, stepTime: 0.1, textureSize: Vector2(32, 32)));
  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
      'Run.png',
      SpriteAnimationData.sequenced(
          amount: 12, stepTime: 0.1, textureSize: Vector2(32, 32)));
  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(idleRight: idleRight, runRight: runRight);
}

class Ninja extends SimplePlayer {
  Ninja(Vector2 position)
      : super(
            position: position,
            size: Vector2(32, 32),
            animation: PlayerSpriteSheet.simpleDirectionAnimation);
}

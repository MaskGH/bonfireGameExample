import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bonfire_first/actors/ninja.dart';

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

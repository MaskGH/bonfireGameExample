import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bonfire_first/actors/goblin.dart';
import 'package:flutter_bonfire_first/actors/knight.dart';

const double tileSize = 32;

class BonfireGameExample extends StatefulWidget {
  const BonfireGameExample({super.key});

  @override
  State<BonfireGameExample> createState() => _BonfireGameExampleState();
}

class _BonfireGameExampleState extends State<BonfireGameExample> {
  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      joystick: Joystick(
          directional: JoystickDirectional(color: Colors.orange),
          actions: [
            JoystickAction(
                actionId: 1,
                color: Colors.orange,
                margin: const EdgeInsets.all(40))
          ]),
      map: WorldMapByTiled('1.json',
          forceTileSize: Vector2(tileSize, tileSize),
          objectsBuilder: {
            'goblin': (properties) => Goblin(properties.position)
          }),
      player: Knight(
        Vector2(40, 40),
      ),
      showCollisionArea: false,
      cameraConfig: CameraConfig(
          moveOnlyMapArea: true,
          sizeMovementWindow: Vector2(tileSize * 4, tileSize * 4),
          zoom: 2.5),
    );
  }
}

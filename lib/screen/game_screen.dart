import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bonfire_first/actors/goblin.dart';
import 'package:flutter_bonfire_first/actors/knight.dart';
import 'package:flutter_bonfire_first/controller/my_game_controller.dart';
import 'package:flutter_bonfire_first/decorations/chess.dart';
import 'package:flutter_bonfire_first/decorations/mushroom.dart';
import 'package:flutter_bonfire_first/interface/player_interface.dart';

import '../decorations/lamp.dart';

const double tileSize = 16;

class BonfireGameExample extends StatefulWidget {
  final int stage;
  const BonfireGameExample({super.key, this.stage = 1});

  @override
  State<BonfireGameExample> createState() => _BonfireGameExampleState();
}

class _BonfireGameExampleState extends State<BonfireGameExample> {
  List<GameComponent> enemies = [];

  @override
  void initState() {
    switch (widget.stage) {
      case 1:
        enemies.add(Goblin(_getWorldPosition(14, 19)));
        break;
      case 2:
        enemies.add(Goblin(_getWorldPosition(14, 19)));
        enemies.add(Goblin(_getWorldPosition(24, 19)));
        break;
      case 3:
        enemies.add(Goblin(_getWorldPosition(14, 19)));
        enemies.add(Goblin(_getWorldPosition(24, 19)));
        enemies.add(Goblin(_getWorldPosition(22, 16)));
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      joystick: Joystick(
          keyboardConfig: KeyboardConfig(),
          directional: JoystickDirectional(color: Colors.orange),
          actions: [
            JoystickAction(
                actionId: 1,
                color: Colors.orange,
                margin: const EdgeInsets.all(40))
          ]),
      map: WorldMapByTiled('2.json',
          forceTileSize: Vector2(tileSize, tileSize),
          objectsBuilder: {
            // 'goblin': (properties) => Goblin(properties.position),
            'lamp': (properties) => Lamp(properties.position),
            'mushroom': (properties) => MushRoom(properties.position),
            'chess': (properties) => Chess(properties.position)
          }),
      player: Knight(
        Vector2(220, 200),
      ),
      components: [MyGameController(widget.stage), ...enemies],
      overlayBuilderMap: {
        PlayerInterFace.overlayKey: (context, game) =>
            PlayerInterFace(game: game)
      },
      initialActiveOverlays: const [PlayerInterFace.overlayKey],
      showCollisionArea: false,
      cameraConfig: CameraConfig(
        moveOnlyMapArea: true,
        sizeMovementWindow: Vector2(tileSize * 4, tileSize * 4),
        zoom: 2.5,
        smoothCameraEnabled: true,
      ),
      lightingColorGame: Colors.black.withOpacity(0.5),
    );
  }

  @override
  void updateGame() {}

  Vector2 _getWorldPosition(int x, int y) {
    return Vector2(x * tileSize, y * tileSize);
  }
}

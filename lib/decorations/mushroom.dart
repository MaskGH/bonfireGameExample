import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bonfire_first/actors/knight.dart';
import 'package:flutter_bonfire_first/decorations/decoration_sprite_sheet.dart';
import 'package:flutter_bonfire_first/screen/game_screen.dart';

class MushRoom extends GameDecoration with Sensor {
  MushRoom(Vector2 position)
      : super.withSprite(
            sprite: DecorationSpriteSheet.mushRoom,
            position: position,
            size: Vector2(16, 16)) {}

  @override
  void onContact(GameComponent component) {
    if (component is Knight) {
      (component).addLife(20);
      removeFromParent();
    }
  }

  @override
  void onMount() {
    final initialPosition = position.translate(0, tileSize / 2);
    const deslocametoX = tileSize;
    const deslocametoY = tileSize;
    gameRef.map.generateValues(const Duration(milliseconds: 100),
        onChange: (value) {
      double nexX = Curves.decelerate.transform(Random().nextDouble());
      double nexY = Curves.bounceInOut.transform(Random().nextDouble());
      position = initialPosition.translate(nexX, nexY);
    }).start();

    super.onMount();
  }
}

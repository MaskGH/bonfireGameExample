import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bonfire_first/actors/knight.dart';
import 'package:flutter_bonfire_first/decorations/decoration_sprite_sheet.dart';
import 'package:flutter_bonfire_first/decorations/mushroom.dart';
import 'package:flutter_bonfire_first/screen/game_screen.dart';

class Chess extends GameDecoration with ObjectCollision {
  bool _playerIsClose = false;
  Sprite? chess, chessOpen;
  Chess(Vector2 position)
      : super.withSprite(
            sprite: DecorationSpriteSheet.chess,
            position: position,
            size: Vector2(16, 32)) {
    setupCollision(CollisionConfig(collisions: [
      CollisionArea.rectangle(size: Vector2(16, 32), align: Vector2(0, 16))
    ]));
  }

  @override
  void update(double dt) {
    seeComponentType<Knight>(
      observed: (p0) {
        if (!_playerIsClose) {
          _playerIsClose = true;
          // _showDialog();
          gameRef.add(MushRoom(center.translate(tileSize, 0)));
        }
      },
      notObserved: () {
        _playerIsClose = false;
      },
      radiusVision: tileSize,
    );
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (_playerIsClose) {
      sprite = chessOpen;
    } else {
      sprite = chess;
    }
    super.render(canvas);
  }

  @override
  Future<void> onLoad() async {
    chess = await DecorationSpriteSheet.chess;
    chessOpen = await DecorationSpriteSheet.chessOpen;
    return super.onLoad();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(content: const Text("안녕하세요"), actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("확인")),
        ]);
      },
    );
  }
}

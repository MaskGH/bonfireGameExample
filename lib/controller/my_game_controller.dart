import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bonfire_first/pages/home_page.dart';
import 'package:flutter_bonfire_first/screen/game_screen.dart';

class MyGameController extends GameComponent {
  bool endGame = false;
  bool gameOver = false;
  final int stage;

  MyGameController(this.stage);
  @override
  void update(double dt) {
    if (checkInterval('end game', 500, dt)) {
      if (gameRef.livingEnemies().isEmpty && !endGame) {
        endGame = true;
        if (stage == 3) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text('다시 처음으로 돌아가요.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        _goHome();
                      },
                      child: const Text('확인')),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text('모두를 물리쳤군요.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        _goStage(stage + 1);
                      },
                      child: const Text('확인'))
                ],
              );
            },
          );
        }
      }
    }
    if (checkInterval('gameover', 500, dt)) {
      if (gameRef.player?.isDead == true && !gameOver) {
        gameOver = true;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text('다시하세요'),
              actions: [
                TextButton(
                    onPressed: () {
                      _goStage(stage);
                    },
                    child: const Text('확인')),
                TextButton(
                    onPressed: () {
                      _goHome();
                    },
                    child: const Text('홈으로 돌아가기'))
              ],
            );
          },
        );
      }
    }

    super.update(dt);
  }

  void _goStage(int newStage) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return BonfireGameExample(
          stage: newStage,
        );
      },
    ), (route) => false);
  }

  void _goHome() {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return const HomePage();
      },
    ), (route) => false);
  }
}

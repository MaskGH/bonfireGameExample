// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter_bonfire_first/actors/knight.dart';
import 'package:flutter_bonfire_first/screen/game_screen.dart';

class GoblinSpriteSheet {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
      'goblin_idle.png',
      SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(0, 0)));
  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
      'goblin_run.png',
      SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(0, 0)));
  static Future<SpriteAnimation> get dieRight => SpriteAnimation.load(
      'die.png',
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(0, 0)));

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(idleRight: idleRight, runRight: runRight);
}

class Goblin extends SimpleEnemy with ObjectCollision, AutomaticRandomMovement {
  bool canMove = true;
  Goblin(Vector2 position)
      : super(
            position: position,
            speed: 20,
            size: Vector2(
              tileSize,
              tileSize,
            ),
            animation: SimpleDirectionAnimation(
                idleRight: GoblinSpriteSheet.idleRight,
                runRight: GoblinSpriteSheet.runRight)) {
    setupCollision(CollisionConfig(
        collisions: [CollisionArea.circle(radius: 12, align: Vector2(3, 7))]));
  }

  void _executeAttack() {
    simpleAttackMelee(
        damage: 10,
        size: size * 0.5,
        sizePush: 16 * 0.5,
        animationRight: PlayerSpriteSheet.attackRight);
  }

  @override
  void update(double dt) {
    if (canMove) {
      seePlayer(
          observed: (p0) {
            seeAndMoveToPlayer(
                closePlayer: (p0) {
                  _executeAttack();
                },
                radiusVision: tileSize * 2,
                margin: 4);
          },
          notObserved: () {
            runRandomMovement(dt);
          },
          radiusVision: tileSize * 2);

      super.update(dt);
    }

    @override
    void render(Canvas canvas) {
      drawDefaultLifeBar(canvas,
          borderWidth: 2, height: 2, align: const Offset(0, 5));

      super.render(canvas);
    }

    @override
    void die() {
      if (lastDirectionHorizontal == Direction.left) {
        animation?.playOnce(
          GoblinSpriteSheet.dieRight,
          runToTheEnd: true,
          onFinish: () {
            removeFromParent();
          },
        );
      } else {
        animation?.playOnce(
          GoblinSpriteSheet.dieRight,
          runToTheEnd: true,
          onFinish: () {
            removeFromParent();
          },
        );
      }
      super.die();
    }

    @override
    void receiveDamage(AttackFromEnum attacker, double damage, identify) {
      canMove = false;
      if (lastDirectionHorizontal == Direction.left) {
        animation?.playOnce(
          GoblinSpriteSheet.idleRight,
          runToTheEnd: true,
          onFinish: () {
            canMove = true;
          },
        );
      } else {
        animation?.playOnce(
          GoblinSpriteSheet.idleRight,
          runToTheEnd: true,
          onFinish: () {
            canMove = true;
          },
        );
      }
      super.receiveDamage(attacker, damage, identify);
    }
  }
}

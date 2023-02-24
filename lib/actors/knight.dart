import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bonfire_first/screen/game_screen.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
      'knight_idle.png',
      SpriteAnimationData.sequenced(
          amount: 5, stepTime: 0.1, textureSize: Vector2(16, 16)));
  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
      'knight_run.png',
      SpriteAnimationData.sequenced(
          amount: 5, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
      'slash.png',
      SpriteAnimationData.sequenced(
          amount: 3, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
      );
}

class Knight extends SimplePlayer with ObjectCollision, Lighting, TapGesture {
  bool canMove = true;
  Knight(Vector2 position)
      : super(
          position: position,
          size: Vector2(16, 16),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          speed: 60,
        ) {
    setupCollision(CollisionConfig(
        collisions: [CollisionArea.circle(radius: 12, align: Vector2(3, 7))]));
    // setupMoveToPositionAlongThePath(
    //     showBarriersCalculated: true, gridSizeIsCollisionSize: true);
    setupLighting(LightingConfig(
        radius: tileSize * 2, color: Colors.transparent, withPulse: true));
  }
  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN &&
        (event.id == 1 || event.id == LogicalKeyboardKey.space.keyId)) {
      _executeAttack();
    }
    super.joystickAction(event);
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (canMove) {
      super.joystickChangeDirectional(event);
    }
  }

  void _executeAttack() {
    simpleAttackMelee(
        damage: 5,
        size: size * 0.5,
        sizePush: 16 * 0.5,
        animationRight: PlayerSpriteSheet.attackRight);
  }

  @override
  void die() {
    if (lastDirectionHorizontal == Direction.left) {
      animation?.playOnce(
        PlayerSpriteSheet.idleRight,
        runToTheEnd: true,
        onFinish: () {
          removeFromParent();
        },
      );
    } else {
      animation?.playOnce(
        PlayerSpriteSheet.idleRight,
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
        PlayerSpriteSheet.idleRight,
        runToTheEnd: true,
        onFinish: () {
          canMove = true;
        },
      );
    } else {
      animation?.playOnce(
        PlayerSpriteSheet.idleRight,
        runToTheEnd: true,
        onFinish: () {
          canMove = true;
        },
      );
    }
    super.receiveDamage(attacker, damage, identify);
  }

  @override
  void onTap() {
    // TalkDialog(says: [
    //   Say(
    //       text: [TextSpan(text: '안녕하세요')],
    //       person: PlayerSpriteSheet.idleRight.asWidget())
    // ]);
    if (FollowerWidget.isVisible('identify')) {
      FollowerWidget.remove("identify");
    } else {
      FollowerWidget.show(
          identify: 'identify',
          context: context,
          target: this,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  Icon(Icons.add),
                  Text('안녕'),
                  ElevatedButton(onPressed: () {}, child: Text('굿'))
                ],
              ),
            ),
          ));
    }
  }
}

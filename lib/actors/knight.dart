import 'package:bonfire/bonfire.dart';

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

class Knight extends SimplePlayer with ObjectCollision {
  Knight(Vector2 position)
      : super(
          position: position,
          size: Vector2(32, 32),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          speed: 60,
        ) {
    setupCollision(CollisionConfig(
        collisions: [CollisionArea.circle(radius: 12, align: Vector2(3, 7))]));
  }
  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN && event.id == 1) {
      _executeAttack();
    }
    super.joystickAction(event);
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
    removeFromParent();
    super.die();
  }
}

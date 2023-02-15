import 'package:bonfire/bonfire.dart';

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

class Ninja extends SimplePlayer with ObjectCollision {
  Ninja(Vector2 position)
      : super(
          position: position,
          size: Vector2(32, 32),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          speed: 60,
        ) {
    setupCollision(CollisionConfig(
        collisions: [CollisionArea.circle(radius: 12, align: Vector2(3, 7))]));
  }
}

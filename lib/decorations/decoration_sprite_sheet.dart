import 'package:bonfire/bonfire.dart';

class DecorationSpriteSheet {
  static Future<Sprite> get chess => Sprite.load('decoration.png',
      srcPosition: Vector2(16, 80), srcSize: Vector2(16, 32));
  static Future<Sprite> get chessOpen => Sprite.load('decoration.png',
      srcPosition: Vector2(32, 80), srcSize: Vector2(16, 32));
  static Future<Sprite> get mushRoom => Sprite.load('decoration.png',
      srcPosition: Vector2(144, 32), srcSize: Vector2(16, 16));
}

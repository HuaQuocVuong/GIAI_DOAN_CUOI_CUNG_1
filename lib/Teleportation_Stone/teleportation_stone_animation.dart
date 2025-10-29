import 'package:flame/components.dart';

class TeleportationStoneAnimation {
  late SpriteAnimation teleportationStoneAnimation;

  TeleportationStoneAnimation();

  Future<void> loadAllAnimations() async {
    teleportationStoneAnimation = await _createTeleportationStoneAnimation();
  }

  Future<SpriteAnimation> _createTeleportationStoneAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('Flying_stone1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('Flying_stone2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('Flying_stone3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('Flying_stone4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('Flying_stone5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('Flying_stone6.png');
    sprites.add(sprite6);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1,
      loop: true,
    );
  }
}

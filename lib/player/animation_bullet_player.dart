import 'package:flame/components.dart';

class BulletAnimations {
  late SpriteAnimation bulletFlyRight;
  late SpriteAnimation bulletFlyLeft;

  late SpriteAnimation bulletHitRight;
  late SpriteAnimation bulletHitLeft;

  BulletAnimations();

  Future<void> loadAllAnimations() async {
    bulletFlyRight = await _createBulletFlyRightAnimation();
    bulletFlyLeft = await _createBulletFlyLeftAnimation();

    bulletHitRight = await _createBulletHitrRightAnimation();
    bulletHitLeft = await _createBulletHitLeftAnimation();
  }
  
  Future<SpriteAnimation> _createBulletFlyRightAnimation() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('slimerunr1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('slimerunr2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('slimerunr3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('slimerunr4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('slimerunr5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('slimerunr6.png');
    sprites.add(sprite6);
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.05, // Tốc độ animation nhanh cho hiệu ứng bay
      loop: true,
    );
  }

  Future<SpriteAnimation> _createBulletFlyLeftAnimation() async {
    final sprites = <Sprite>[];
    
    // CHÈN CÁC ẢNH HOẠT HÌNH BAY SANG TRÁI VÀO ĐÂY:
    final sprite1 = await Sprite.load('slimerunl1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('slimerunl2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('slimerunl3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('slimerunl4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('slimerunl5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('slimerunl6.png');
    sprites.add(sprite6);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.05,
      loop: true,
    );
  }

  Future<SpriteAnimation> _createBulletHitrRightAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg1_blefr2.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_blefr2.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_blefr2.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_blefr2.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_blefr2.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg1_blefr2.6.png');
    sprites.add(sprite6);
    

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.09,
      loop: true,
    );
  }
  Future<SpriteAnimation> _createBulletHitLeftAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg1_blefl2.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_blefl2.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_blefl2.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_blefl2.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_blefl2.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg1_blefl2.6.png');
    sprites.add(sprite6);
    
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.09,
      loop: true,
    );
  }



  // 🎬 PHƯƠNG THỨC ĐỂ LẤY ANIMATION THEO HƯỚNG
  SpriteAnimation getFlyAnimation(bool isFacingRight) {
    return isFacingRight ? bulletFlyRight : bulletFlyLeft;
  }
}
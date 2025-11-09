import 'package:flame/components.dart';

//Note: Flame components:
// SpriteAnimation: Quản lý hoạt hình sprite
// Sprite: Đại diện cho một hình ảnh 2D
// SpriteAnimationComponent: Thành phần hiển thị hoạt hình sprite trong game
// SpriteAnimationData: Cung cấp dữ liệu cấu hình cho hoạt hình sprite
// SpriteAnimationFrameData: Cung cấp dữ liệu cho từng khung hình trong hoạt hình sprite

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
  //Animation đạn bay sang phải
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
      stepTime: 0.05,
      loop: true,
    );
  }

  //Animation đạn bay sang trái
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

  // Animation đạn trúng bên phải mục tiêu 
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

  // Animation đạn trúng bên trái mục tiêu
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

  // Lấy animation bay dựa trên hướng
  SpriteAnimation getFlyAnimation(bool isFacingRight) {
    return isFacingRight ? bulletFlyRight : bulletFlyLeft;
  }
}
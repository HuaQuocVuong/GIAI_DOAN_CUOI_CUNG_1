import 'package:flame/components.dart';

class BossBulletAnimations {

  late SpriteAnimation bulletFlyRight;
  late SpriteAnimation bulletFlyLeft;
  late SpriteAnimation bulletHitEffectRight;
  late SpriteAnimation bulletHitEffectLeft;


  late SpriteAnimation bulletFlyRight2;
  late SpriteAnimation bulletFlyLeft2;
  late SpriteAnimation bulletHitEffectRight2;
  late SpriteAnimation bulletHitEffectLeft2;

  
  BossBulletAnimations();

  Future<void> loadAllAnimations() async {
    bulletFlyRight = await _createBulletFlyRightAnimation();
    bulletFlyLeft = await _createBulletFlyLeftAnimation();
    bulletHitEffectRight = await _createBulletHitEffectRightAnimation();
    bulletHitEffectLeft = await _createBulletHitEffectLeftAnimation();

    bulletFlyRight2 = await _createBulletFlyRight2Animation();
    bulletFlyLeft2 = await _createBulletFlyLeft2Animation();
    bulletHitEffectRight2 = await _createBulletHitEffectRight2Animation();
    bulletHitEffectLeft2 = await _createBulletHitEffectLeft2Animation();

  }

  // ĐẠN BOSS BAY SANG PHẢI
  Future<SpriteAnimation> _createBulletFlyRightAnimation() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('tg1_blr1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_blr1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_blr1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_blr1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_blr1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg1_blr1.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tg1_blr1.7.png');
    sprites.add(sprite7);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1, // Tốc độ animation
      loop: true,
    );
  }

  // ĐẠN BOSS BAY SANG TRÁI
  Future<SpriteAnimation> _createBulletFlyLeftAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg1_bll1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_bll1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_bll1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_bll1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_bll1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg1_bll1.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tg1_bll1.7.png');
    sprites.add(sprite7);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1,
      loop: true,
    );
  }

  // HIỆU ỨNG NỔ KHI ĐẠN VA CHẠM BÊN PHẢI NGƯỜI CHƠI
  Future<SpriteAnimation> _createBulletHitEffectRightAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg1_blefr1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_blefr1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_blefr1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_blefr1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_blefr1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg1_blefr1.6.png');
    sprites.add(sprite6);
        
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.08,
      loop: false,
    );
  }

  // HIỆU ỨNG NỔ KHI ĐẠN VA CHẠM BÊN TRÁI NGƯỜI CHƠI
  Future<SpriteAnimation> _createBulletHitEffectLeftAnimation() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('tg1_blefl1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_blefl1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_blefl1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_blefl1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_blefl1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg1_blefl1.6.png');
    sprites.add(sprite6);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.08,
      loop: false,
    );
  }

  // ĐẠN BOSS BAY SANG PHẢI
  Future<SpriteAnimation> _createBulletFlyRight2Animation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg1_blr2.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_blr2.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_blr2.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_blr2.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_blr2.5.png');
    sprites.add(sprite5);
 
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.09, // Tốc độ animation
      loop: true,
    );
  }
  // ĐẠN BOSS BAY SANG PHẢI
  Future<SpriteAnimation> _createBulletFlyLeft2Animation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg1_bll2.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_bll2.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_bll2.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_bll2.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_bll2.5.png');
    sprites.add(sprite5);
    
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1, // Tốc độ animation
      loop: true,
    );
  }


  // HIỆU ỨNG NỔ KHI ĐẠN VA CHẠM BÊN PHẢI NGƯỜI CHƠI
  Future<SpriteAnimation> _createBulletHitEffectRight2Animation() async {
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
      stepTime: 0.08,
      loop: false,
    );
  }

  // HIỆU ỨNG NỔ KHI ĐẠN VA CHẠM BÊN PHẢI NGƯỜI CHƠI
  Future<SpriteAnimation> _createBulletHitEffectLeft2Animation() async {
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
      stepTime: 0.08,
      loop: false,
    );
  }

  // PHƯƠNG THỨC ĐỂ LẤY ANIMATION THEO HƯỚNG
  SpriteAnimation getFlyAnimation(bool isFacingRight) {
    return isFacingRight ? bulletFlyRight : bulletFlyLeft;
  }

  // PHƯƠNG THỨC MỚI: LẤY ANIMATION NỔ THEO HƯỚNG
  SpriteAnimation getHitEffectAnimation(bool isFacingRight) {
    return isFacingRight ? bulletHitEffectRight : bulletHitEffectLeft;
  }

  // PHƯƠNG THỨC TIỆN ÍCH ĐỂ LẤY ANIMATION THEO TÊN
  SpriteAnimation? getAnimationByName(String name) {
    switch (name) {
      case 'flyRight':
        return bulletFlyRight;
      case 'flyLeft':
        return bulletFlyLeft;

      case 'hitEffectRight':
        return bulletHitEffectRight;
      case 'hitEffectLeft':
        return bulletHitEffectLeft;

      case 'flyRight2':
        return bulletFlyRight2;
      case 'flyLeft2':
        return bulletFlyLeft2;

      case 'hitEffectRight2':
        return bulletHitEffectRight2;
      case 'hitEffectLeft2':
        return bulletHitEffectLeft2;

      default:
        return null;
    }
  }
}
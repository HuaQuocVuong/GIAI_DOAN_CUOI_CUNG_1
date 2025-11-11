import 'package:flame/components.dart';

enum LightningType {
  type1,
  type2,  
  type3,
}

class LightningAnimationManager {
  // ANIMATION SÉT LOẠI 1 - 9 ẢNH
  static Future<SpriteAnimation> createLightningType1Animation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('lining1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('lining1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('lining1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('lining1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('lining1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('lining1.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('lining1.7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('lining1.8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('lining1.9.png');
    sprites.add(sprite9);
   
    

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.08,
      loop: true,
    );
  }

  static Future<SpriteAnimation> createLightningType2Animation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('lining2.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('lining2.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('lining2.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('lining2.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('lining2.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('lining2.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('lining2.7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('lining2.8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('lining2.9.png');
    sprites.add(sprite9);
   
    

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.08,
      loop: true,
    );
  }

  static Future<SpriteAnimation> createLightningType3Animation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('lining3.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('lining3.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('lining3.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('lining3.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('lining3.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('lining3.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('lining3.7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('lining3.8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('lining3.9.png');
    sprites.add(sprite9);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.08,
      loop: true,
    );
  }

  // HÀM TỔNG ĐỂ LẤY ANIMATION THEO TYPE
  static Future<SpriteAnimation> getAnimationByType(LightningType type) async {
    switch (type) {
      case LightningType.type1:
        return await createLightningType1Animation();
      case LightningType.type2:
        return await createLightningType2Animation();
      case LightningType.type3:
        return await createLightningType3Animation();
    }
  }
}
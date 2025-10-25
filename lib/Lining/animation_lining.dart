import 'package:flame/components.dart';

enum LightningType {
  type1,
  //type2,  
  //type3,
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

/*
  // ANIMATION SÉT LOẠI 2 - 9 ẢNH
  static Future<SpriteAnimation> createLightningType2Animation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('lightning1_type2.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('lightning2_type2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('lightning3_type2.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('lightning4_type2.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('lightning5_type2.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('lightning6_type2.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('lightning7_type2.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('lightning8_type2.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('lightning9_type2.png');
    sprites.add(sprite9);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.08,
      loop: true,
    );
  }

  // ANIMATION SÉT LOẠI 3 - 9 ẢNH
  static Future<SpriteAnimation> createLightningType3Animation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('lightning1_type3.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('lightning2_type3.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('lightning3_type3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('lightning4_type3.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('lightning5_type3.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('lightning6_type3.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('lightning7_type3.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('lightning8_type3.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('lightning9_type3.png');
    sprites.add(sprite9);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.08,
      loop: true,
    );
  }
*/
  // HÀM TỔNG ĐỂ LẤY ANIMATION THEO TYPE
  static Future<SpriteAnimation> getAnimationByType(LightningType type) async {
    switch (type) {
      case LightningType.type1:
        return await createLightningType1Animation();
      //case LightningType.type2:
      //  return await createLightningType2Animation();
      //case LightningType.type3:
      //  return await createLightningType3Animation();
    }
  }
}
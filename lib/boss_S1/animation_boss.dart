import 'package:flame/components.dart';

class BossAnimations {
  late SpriteAnimation idleLeft;

  late SpriteAnimation attackLeft;
  late SpriteAnimation attackRight;

    late SpriteAnimation attackLeft2;
  late SpriteAnimation attackRight2;

  late SpriteAnimation deathLeft;  


  BossAnimations();

  Future<void> loadAllAnimations() async {
    idleLeft = await _createIdleLeftAnimation();

    attackLeft = await _createAttackLeftAnimation();
    attackRight = await _createAttackRightAnimation();

    attackLeft2 = await _createAttackLeft2Animation();
    attackRight2 = await _createAttackRight2Animation();

    deathLeft = await _createDeathLeftAnimation();
  }

//IDLE LEFT
  Future<SpriteAnimation> _createIdleLeftAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg1_idlel1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_idlel2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_idlel3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_idlel4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_idlel5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg1_idlel6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tg1_idlel7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tg1_idlel8.png');
    sprites.add(sprite8);



    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.15,
      loop: true,
    );
  }

  //ATTACK LEFT TARGET 
  Future<SpriteAnimation> _createAttackRightAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg1_atl1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_atl1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_atl1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_atl1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_atl1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg1_atl1.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tg1_atl1.7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tg1_atl1.8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('tg1_atl1.9.png');
    sprites.add(sprite9);
    final sprite10 = await Sprite.load('tg1_atl1.10.png');
    sprites.add(sprite10);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1,
      loop: false,
    );
  }

  //ATTACK LEFT TARGET 
  Future<SpriteAnimation> _createAttackLeftAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg1_atl2.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_atl2.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_atl2.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_atl2.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_atl2.7.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg1_atl2.7.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tg1_atl2.7.png');
    sprites.add(sprite7);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1, //0.1
      loop: false,
    );
  }


  Future<SpriteAnimation> _createAttackRight2Animation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg1_atr2.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_atr2.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_atr2.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_atr2.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_atr2.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg1_atr2.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tg1_atr2.7.png');
    sprites.add(sprite7);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1,
      loop: false,
    );
  }
  Future<SpriteAnimation> _createAttackLeft2Animation() async {
    final sprites = <Sprite>[];


    final sprite1 = await Sprite.load('tg1_atl1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg1_atl1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg1_atl1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg1_atl1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg1_atl1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg1_atl1.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tg1_atl1.7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tg1_atl1.8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('tg1_atl1.9.png');
    sprites.add(sprite9);
    final sprite10 = await Sprite.load('tg1_atl1.10.png');
    sprites.add(sprite10);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1, //0.1
      loop: false,
    );
  }


  //
  Future<SpriteAnimation> _createDeathLeftAnimation() async {
    final frames = <Future<SpriteAnimationFrame>>[];

    frames.add(_createFrame('tg1_deathefl1.png', 0.4));
    frames.add(_createFrame('tg1_deathefl2.png', 0.4));
    frames.add(_createFrame('tg1_deathefl3.png', 0.4));
    frames.add(_createFrame('tg1_deathefl4.png', 0.4));
    frames.add(_createFrame('tg1_deathefl5.png', 0.4));
    frames.add(_createFrame('tg1_deathefl6.png', 0.4));
    frames.add(_createFrame('tg1_deathefl7.png', 0.4));
    frames.add(_createFrame('tg1_deathefl8.png', 0.4));
    frames.add(_createFrame('tg1_deathefl9.png', 0.4));
    frames.add(_createFrame('tg1_deathefl10.png', 0.4));

    frames.add(_createFrame('tgdeathl12.png', 0.05));
    frames.add(_createFrame('tgdeathl13.png', 0.04));
    frames.add(_createFrame('tgdeathl14.png', 0.03));
    frames.add(_createFrame('tgdeathl15.png', 0.02));
    frames.add(_createFrame('tgdeathl16.png', 0.03));
    frames.add(_createFrame('tgdeathl17.png', 0.02));

     final loadedFrames = await Future.wait(frames);
     return SpriteAnimation(loadedFrames, loop: false);
  }
  // 🎬 PHƯƠNG THỨC HỖ TRỢ TẠO FRAME
  Future<SpriteAnimationFrame> _createFrame(String path, double stepTime) async {
    final sprite = await Sprite.load(path);
    return SpriteAnimationFrame(sprite, stepTime);
  }


  // 🎬 Phương thức tiện ích để lấy animation theo tên
  SpriteAnimation? getAnimationByName(String name) {
    switch (name) {
    

      case 'idleLeft': 
        return idleLeft;
  

      case 'attackLeft':
        return attackLeft;
      case 'attackRight':
        return attackRight;

      case 'attackLeft2':
        return attackLeft2;
      case 'attackRight2':
        return attackRight2;

      case 'deathLeft': 
        return deathLeft;

      default:
        return null;
    }
  }
}
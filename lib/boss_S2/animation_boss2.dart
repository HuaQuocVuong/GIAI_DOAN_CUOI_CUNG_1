import 'package:flame/components.dart';

class Boss2Animations {
  
  late SpriteAnimation idleRight;
  late SpriteAnimation idleLeft;

  late SpriteAnimation walkRight;
  late SpriteAnimation walkLeft;

  late SpriteAnimation runRight;
  late SpriteAnimation runLeft;

  late SpriteAnimation attackRight;
  late SpriteAnimation attackLeft;

  late SpriteAnimation attackRight2;
  late SpriteAnimation attackLeft2;

  late SpriteAnimation dieRight;
  late SpriteAnimation dieLeft;



  Boss2Animations();

  Future<void> loadAllAnimations() async {
    idleRight = await _createIdleRightAnimation();
    idleLeft = await _createIdleLeftAnimation();

    walkRight = await _createWalkRightAnimation();
    walkLeft = await _createWalkLeftAnimation();
    
    runRight = await _createRunRightAnimation();
    runLeft = await _createRunLeftAnimation();



    attackRight = await _createAttackRight();
    attackLeft = await _createAttackLeft();

    attackRight2 = await _createAttackRight2();
    attackLeft2 = await _createAttackLeft2();


    dieRight = await _createDieRight();
    dieLeft = await _createDieLeft();
    
  }

//IDLE LEFT
 Future<SpriteAnimation> _createIdleRightAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg2_idler1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_idler2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_idler3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_idler4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg2_idler5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg2_idler6.png');
    sprites.add(sprite6);
  
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.15,
      loop: true,
    );
  }
  Future<SpriteAnimation> _createIdleLeftAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg2_idlel1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_idlel2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_idlel3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_idlel4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg2_idlel5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg2_idlel6.png');
    sprites.add(sprite6);
  
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.15,
      loop: true,
    );
  }


  
  Future<SpriteAnimation> _createWalkRightAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg2_wr1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_wr2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_wr3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_wr4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg2_wr5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg2_wr6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tg2_wr7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tg2_wr8.png');
    sprites.add(sprite8);


    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.15,
      loop: true,
    );
  }
  Future<SpriteAnimation> _createWalkLeftAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg2_wl1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_wl2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_wl3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_wl4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg2_wl5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg2_wl6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tg2_wl7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tg2_wl8.png');
    sprites.add(sprite8);

    
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.15,
      loop: true,
    );
  }


  Future<SpriteAnimation> _createRunRightAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg2_runr1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_runr2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_runr3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_runr4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg2_runr5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg2_runr6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tg2_runr7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tg2_runr8.png');
    sprites.add(sprite8);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.15,
      loop: true,
    );
  }

  Future<SpriteAnimation> _createRunLeftAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tg2_runl1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_runl2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_runl3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_runl4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg2_runl5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg2_runl6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tg2_runl7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tg2_runl8.png');
    sprites.add(sprite8);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.15,
      loop: true,
    );
  }

  Future <SpriteAnimation> _createAttackRight() async {
    final sprites = <Sprite> [];

    final sprite1 = await Sprite.load('tg2_atr1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_atr2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_atr3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_atr4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg2_atr5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg2_atr6.png');
    sprites.add(sprite6);

    return SpriteAnimation.spriteList(
      sprites, 
      stepTime: 0.10,
      loop: true);

  }
  Future <SpriteAnimation> _createAttackLeft() async {
    final sprites = <Sprite> [];

    final sprite1 = await Sprite.load('tg2_atl1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_atl2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_atl3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_atl4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg2_atl5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg2_atl6.png');
    sprites.add(sprite6);

    return SpriteAnimation.spriteList(
      sprites, 
      stepTime: 0.10,
      loop: true);
  }

  Future <SpriteAnimation> _createAttackRight2() async {
    final sprites = <Sprite> [];

    final sprite1 = await Sprite.load('tg2_atr2.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_atr2.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_atr2.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_atr2.4.png');
    sprites.add(sprite4);

    return SpriteAnimation.spriteList(
      sprites, 
      stepTime: 0.10,
      loop: true);
  }
  Future <SpriteAnimation> _createAttackLeft2() async {
    final sprites = <Sprite> [];

    final sprite1 = await Sprite.load('tg2_atl2.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_atl2.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_atl2.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_atl2.4.png');
    sprites.add(sprite4);
    
    return SpriteAnimation.spriteList(
      sprites, 
      stepTime: 0.10,
      loop: true);
  }

  Future <SpriteAnimation> _createDieRight() async {
    final frames = <Future<SpriteAnimationFrame>>[];

    frames.add(_createFrame('tg2_dier1.png', 0.4));
    frames.add(_createFrame('tg2_dier2.png', 0.4));
    frames.add(_createFrame('tg2_dier3.png', 0.4));
    frames.add(_createFrame('tg2_dier4.png', 0.4));
    frames.add(_createFrame('tg2_dier5.png', 0.4));
    frames.add(_createFrame('tg2_dier6.png', 0.4));
    
    frames.add(_createFrame('tgdeathl12.png', 0.05));
    frames.add(_createFrame('tgdeathl13.png', 0.04));
    frames.add(_createFrame('tgdeathl14.png', 0.03));
    frames.add(_createFrame('tgdeathl15.png', 0.02));
    frames.add(_createFrame('tgdeathl16.png', 0.03));
    frames.add(_createFrame('tgdeathl17.png', 0.02));

    final loadedFrames = await Future.wait(frames);
    return SpriteAnimation(loadedFrames, loop: false);
  }

  Future <SpriteAnimation> _createDieLeft() async {
    final frames = <Future<SpriteAnimationFrame>>[];

    frames.add(_createFrame('tg2_diel1.png', 0.4));
    frames.add(_createFrame('tg2_diel2.png', 0.4));
    frames.add(_createFrame('tg2_diel3.png', 0.4));
    frames.add(_createFrame('tg2_diel4.png', 0.4));
    frames.add(_createFrame('tg2_diel5.png', 0.4));
    frames.add(_createFrame('tg2_diel6.png', 0.4));

    frames.add(_createFrame('tgdeathl12.png', 0.05));
    frames.add(_createFrame('tgdeathl13.png', 0.04));
    frames.add(_createFrame('tgdeathl14.png', 0.03));
    frames.add(_createFrame('tgdeathl15.png', 0.02));
    frames.add(_createFrame('tgdeathl16.png', 0.03));
    frames.add(_createFrame('tgdeathl17.png', 0.02));

    final loadedFrames = await Future.wait(frames);
    return SpriteAnimation(loadedFrames, loop: false);
  }

  // PHƯƠNG THỨC HỖ TRỢ TẠO FRAME
  Future<SpriteAnimationFrame> _createFrame(String path, double stepTime) async {
    final sprite = await Sprite.load(path);
    return SpriteAnimationFrame(sprite, stepTime);
  }

  // Phương thức tiện ích để lấy animation theo tên
  SpriteAnimation? getAnimationByName(String name) {
    switch (name) {
      case 'idleRight': 
        return idleRight;

      case 'idleLeft': 
        return idleLeft;

      case 'walkRight':
        return  walkRight;
      case 'walkLeft':

      case 'runRight':
        return runRight;
      case 'runLeft':
        return runLeft;
  
      case 'attackRight':
        return attackRight;
      case 'attackLeft':
        return attackLeft;

      case 'attackRight2':
        return attackRight2;
      case 'attackLeft2':
        return attackLeft2;

      case 'dieRight':
        return dieRight;
      case 'dieLeft':
        return dieLeft;

      default:
        return null;
    }
  }
}
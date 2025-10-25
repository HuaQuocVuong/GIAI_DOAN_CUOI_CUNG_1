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

  Future <SpriteAnimation> _createDieRight() async {
    final sprites = <Sprite> [];

    final sprite1 = await Sprite.load('tg2_dier1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_dier2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_dier3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_dier4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg2_dier5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg2_dier6.png');
    sprites.add(sprite6);

    final sprite7 = await Sprite.load('tgdeathl12.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tgdeathl13.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('tgdeathl14.png');
    sprites.add(sprite9);
    final sprite10 = await Sprite.load('tgdeathl15.png');
    sprites.add(sprite10);
    final sprite11 = await Sprite.load('tgdeathl16.png');
    sprites.add(sprite11);
    final sprite12 = await Sprite.load('tgdeathl17.png');
    sprites.add(sprite12);

    return SpriteAnimation.spriteList(
      sprites, 
      stepTime: 0.5,
      loop: true);
  }

  Future <SpriteAnimation> _createDieLeft() async {
    final sprites = <Sprite> [];

    final sprite1 = await Sprite.load('tg2_diel1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tg2_diel2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tg2_diel3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tg2_diel4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tg2_diel5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tg2_diel6.png');
    sprites.add(sprite6);


    final sprite7 = await Sprite.load('tgdeathl12.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tgdeathl13.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('tgdeathl14.png');
    sprites.add(sprite9);
    final sprite10 = await Sprite.load('tgdeathl15.png');
    sprites.add(sprite10);
    final sprite11 = await Sprite.load('tgdeathl16.png');
    sprites.add(sprite11);
    final sprite12 = await Sprite.load('tgdeathl17.png');
    sprites.add(sprite12);


    return SpriteAnimation.spriteList(
      sprites, 
      stepTime: 0.5,
      loop: true);
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

      case 'dieRight':
      return dieRight;
        case 'dieLeft':
        return dieLeft;

      default:
        return null;
    }
  }
}
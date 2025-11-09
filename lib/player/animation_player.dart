import 'package:flame/components.dart';

class PlayerAnimations {
  late SpriteAnimation idle;

  late SpriteAnimation walkRight;
  late SpriteAnimation walkLeft;

  late SpriteAnimation runRight;
  late SpriteAnimation runLeft;

  late SpriteAnimation attackRight;
  late SpriteAnimation attackLeft;

  late SpriteAnimation attackRightCombo;
  late SpriteAnimation attackLeftCombo;

  late SpriteAnimation transitionRight;
  late SpriteAnimation transitionLeft;

  late SpriteAnimation idleSpecial; 

  late SpriteAnimation death; 

  PlayerAnimations();

  Future<void> loadAllAnimations() async {

    idle = await _createIdleAnimation();

    walkRight = await _createWalkRightAnimation();
    walkLeft = await _createWalkLeftAnimation();

    runRight = await _createRunRightAnimation();
    runLeft = await _createRunLeftAnimation();

    attackRight = await _createAttackRightAnimation();
    attackLeft = await _createAttackLeftAnimation();

    attackRightCombo = await _createAttackRightComboAnimation();
    attackLeftCombo = await _createAttackLeftComboAnimation();

    transitionRight = await _createTransitionRightAnimation();
    transitionLeft = await _createTransitionLeftAnimation();

    idleSpecial = await _createIdleSpecialAnimation();
    death = await _createDeathAnimation();
  }

  Future<SpriteAnimation> _createIdleAnimation() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('idlr1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('idlr2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('idlr3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('idlr4.png');
    sprites.add(sprite4);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1,
      loop: true,
    );
  }

  Future<SpriteAnimation> _createIdleSpecialAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('emjjp1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('emjjp2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('emjjp3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('emjjp4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('emjjp5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('emjjp6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('emjjp7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('emjjp8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('emjjp9.png');
    sprites.add(sprite9);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.2,
      loop: false, //  CHẠY 1 LẦN RỒI DỪNG
    );

  }

  Future<SpriteAnimation> _createWalkRightAnimation() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('wr1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('wr2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('wr3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('wr4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('wr5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('wr6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('wr7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('wr8.png');
    sprites.add(sprite8);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.08,
      loop: true,
    );
  }

  Future<SpriteAnimation> _createWalkLeftAnimation() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('wl1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('wl2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('wl3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('wl4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('wl5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('wl6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('wl7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('wl8.png');
    sprites.add(sprite8);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.08,
      loop: true,
    );
  }


  Future<SpriteAnimation> _createRunRightAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('player_runr1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('player_runr2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('player_runr3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('player_runr4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('player_runr5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('player_runr6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('player_runr7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('player_runr8.png');
    sprites.add(sprite8);
  

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.09,
      loop: true,
    );
  }
  Future<SpriteAnimation> _createRunLeftAnimation() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('player_runl1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('player_runl2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('player_runl3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('player_runl4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('player_runl5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('player_runl6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('player_runl7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('player_runl8.png');
    sprites.add(sprite8);
  
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.09, //0.08
      loop: true,
    );
  }


  Future<SpriteAnimation> _createAttackRightAnimation() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('atr1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('atr2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('atr3.png');
    sprites.add(sprite3);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1,
      loop: false,
    );
  }

  Future<SpriteAnimation> _createAttackLeftAnimation() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('atl1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('atl2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('atl3.png');
    sprites.add(sprite3);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1,
      loop: false,
    );
  }

  Future<SpriteAnimation> _createAttackRightComboAnimation() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('atr4.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('atr5.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('atr6.png');
    sprites.add(sprite3);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1,
      loop: false,
    );
  }

  Future<SpriteAnimation> _createAttackLeftComboAnimation() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('atl4.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('atl5.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('atl6.png');
    sprites.add(sprite3);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.1,
      loop: false,
    );

    
  }

  Future<SpriteAnimation> _createTransitionRightAnimation() async {
    final frames = <Future<SpriteAnimationFrame>>[];
    
    frames.add(_createFrame('endatr1.png', 1.5));
    frames.add(_createFrame('endatr2.png', 1.5));
    frames.add(_createFrame('endatr2.png', 1.5));
    
    final loadedFrames = await Future.wait(frames);
    return SpriteAnimation(loadedFrames, loop: false);
  }

  Future<SpriteAnimation> _createTransitionLeftAnimation() async {
    final frames = <Future<SpriteAnimationFrame>>[];
    
    frames.add(_createFrame('endatl1.png', 1.5));
    frames.add(_createFrame('endatl2.png', 1.5));
    frames.add(_createFrame('endatl3.png', 1.5));

    final loadedFrames = await Future.wait(frames);
    return SpriteAnimation(loadedFrames, loop: false);
  }
  Future<SpriteAnimation> _createDeathAnimation() async {
    // Tạo một list các frame với thời gian riêng
    final frames = <Future<SpriteAnimationFrame>>[];
    
    // 🎬 THÊM TỪNG FRAME VỚI STEP TIME RIÊNG
    frames.add(_createFrame('dead1.png', 0.5));
    frames.add(_createFrame('dead2.png', 0.5));
    frames.add(_createFrame('dead3.png', 0.5));
    frames.add(_createFrame('dead4.png', 0.5));
    frames.add(_createFrame('dead5.png', 0.5));
    
    frames.add(_createFrame('deathef1.png', 2.2));
    frames.add(_createFrame('deathef2.png', 2.2));
    frames.add(_createFrame('deathef3.png', 1.8));
    frames.add(_createFrame('deathef4.png', 2.0));
    frames.add(_createFrame('deathef5.png', 2.0));
    frames.add(_createFrame('deathef6.png', 2.0));
    frames.add(_createFrame('deathef7.png', 2.0));
    frames.add(_createFrame('deathef8.png', 2.0));
    frames.add(_createFrame('deathef9.png', 1.8));
    frames.add(_createFrame('deathef10.png', 1.5));
    frames.add(_createFrame('deathef11.png', 1.5));

    frames.add(_createFrame('dead5.png', 0.4));
   
    frames.add(_createFrame('deathef13.png', 1.2));
    frames.add(_createFrame('deathef14.png', 0.2));
    frames.add(_createFrame('deathef15.png', 0.2));
    frames.add(_createFrame('deathef16.png', 0.3));
    frames.add(_createFrame('deathef17.png', 0.3));
    frames.add(_createFrame('deathef18.png', 0.3));

    // Chờ tất cả frames load xong
    final loadedFrames = await Future.wait(frames);
    
    // Tạo animation từ các frame
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
      case 'idle':
        return idle;
      case 'walkRight':
        return walkRight;
      case 'walkLeft':
        return walkLeft;

      case 'runRight':
        return runRight;
      case 'runLeft':
        return runLeft;
      case 'attackRight':
        return attackRight;
      case 'attackLeft':
        return attackLeft;
      case 'attackRightCombo':
        return attackRightCombo;
      case 'attackLeftCombo':
        return attackLeftCombo;
      case 'transitionRight':
        return transitionRight;
      case 'transitionLeft':
        return transitionLeft;
      case 'idleSpecial': 
        return idleSpecial;
      case 'death': 
        return death;
      default:
        return null;
    }
  }
}
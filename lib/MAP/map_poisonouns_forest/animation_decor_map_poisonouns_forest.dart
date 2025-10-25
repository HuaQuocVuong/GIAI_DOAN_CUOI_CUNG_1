import 'package:flame/sprite.dart';

import 'package:flame/components.dart';


enum GroundRocksType {
  type1,  
  type2,  
  type3, 
  type4,   
  type5,  
  
  type6,

  type10, type11, type12, //Water
}

class GroundRocksComponent extends SpriteAnimationComponent with HasGameRef {
  final Vector2 rockPosition;
  final double animationSpeed;
  final GroundRocksType rockType;

  GroundRocksComponent({
    required this.rockPosition,
    required this.rockType,
    this.animationSpeed = 0.1,
    Vector2? size,
  }) : super(
          position: rockPosition, 
          size: size ?? _getSizeByRockType(rockType),
          anchor: Anchor.center,
        );

  // XÁC ĐỊNH KÍCH THƯỚC THEO LOẠI NƯỚC - chỉ dùng cho Poisonous Forest
  static Vector2 _getSizeByRockType(GroundRocksType type) {
    switch (type) {

      // Background water tĩnh - kích thước 100x100
      case GroundRocksType.type1:
        return Vector2(100, 100); 

      // Animation nước động - kích thước 80x60  
      case GroundRocksType.type2:
        return Vector2(120, 12); 
        
      case GroundRocksType.type3:
        return Vector2(64, 64); 


      case GroundRocksType.type4:
        return Vector2(290, 64); 
      case GroundRocksType.type5:
        return Vector2(290, 64);

      case GroundRocksType.type6:
        return Vector2(66, 32);



      //Water
      case GroundRocksType.type10:
        return Vector2(70, 12); 
      case GroundRocksType.type11:
        return Vector2(290, 64);
      case GroundRocksType.type12:
        return Vector2(290, 64); 
  
    
    
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Chọn animation theo loại đá
    switch(rockType) {
      case GroundRocksType.type1:
        animation = await _createRockAnimation1();
        break;

      case GroundRocksType.type2:
        animation = await _createRockAnimation2();
        break;

      case GroundRocksType.type3:
       animation = await _createRockAnimation3();
       break;

      case GroundRocksType.type4:
       animation = await _createRockAnimation4();
       break;
      case GroundRocksType.type5:
       animation = await _createRockAnimation5();
       break;

      case GroundRocksType.type6:
       animation = await _createRockAnimation6();
       break;

     







      //Water
      case GroundRocksType.type10:
       animation = await _createRockAnimation10();
       break;
      case GroundRocksType.type11:
       animation = await _createRockAnimation11();
       break;
      case GroundRocksType.type12:
       animation = await _createRockAnimation12();
       break;
    }
    position = rockPosition;
  }

  // Animation đá loại 1
  Future<SpriteAnimation> _createRockAnimation1() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('bgr_water.png');
    sprites.add(sprite1);
  

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }

  // Animation đá loại 2
  Future<SpriteAnimation> _createRockAnimation2() async {
    final sprites = <Sprite>[];


    final sprite1 = await Sprite.load('water_detilazatio1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('water_detilazatio2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('water_detilazatio3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('water_detilazatio4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('water_detilazatio5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('water_detilazatio6.png');
    sprites.add(sprite6);
    
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
   // Animation đá loại 2
  Future<SpriteAnimation> _createRockAnimation3() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('water_hole1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('water_hole2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('water_hole3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('water_hole4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('water_hole5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('water_hole6.png');
    sprites.add(sprite6);


    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }

  /////////////////////////////////////////////////////////////
  Future<SpriteAnimation> _createRockAnimation4() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('Ground_rocks2.2.png');
    sprites.add(sprite1);
  
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
  Future<SpriteAnimation> _createRockAnimation5() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('Ground_rocks2.3.png');
    sprites.add(sprite1);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
  ////////////////////////////////////////////////////////////////
  Future<SpriteAnimation> _createRockAnimation6() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('stone1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('stone1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('stone1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('stone1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('stone1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('stone1.6.png');
    sprites.add(sprite6);
    
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
  

//Water
  Future<SpriteAnimation> _createRockAnimation10() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('water_detilazatio1.1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('water_detilazatio1.1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('water_detilazatio1.1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('water_detilazatio1.1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('water_detilazatio1.1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('water_detilazatio1.1.6.png');
    sprites.add(sprite6);


    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
  Future<SpriteAnimation> _createRockAnimation11() async {
    final sprites = <Sprite>[];


    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
  Future<SpriteAnimation> _createRockAnimation12() async {
    final sprites = <Sprite>[];


    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
  

}
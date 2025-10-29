import 'package:flame/sprite.dart';

import 'package:flame/components.dart';


enum TreeType {
  //Kiểu cây được thêm vào (Mỗi cây sẽ có 3 kiểu: cây lớn, cây vừa, cây nhỏ)
  type1, type2, type3,  //Kiểu cây 1
  type4, type5, type6,  //Kiểu cây 2
  type7, type8, type9,  //Kiểu cây 3
  type10, type11, type12,
}
class TreeComponent extends SpriteAnimationComponent with HasGameRef {
  final Vector2 treePosition;
  final double animationSpeed;
  final TreeType treeType;

  TreeComponent({
    required this.treePosition,
    required this.treeType,
    this.animationSpeed = 0.5,
    Vector2? size,
  }) : super(
          size: size ?? _getSizeByTreeType(treeType), //Kích thước cây
          anchor: Anchor.bottomCenter,
        );

        static Vector2 _getSizeByTreeType(TreeType type) {
          switch (type) {
            //kiểu cây 1
            case TreeType.type1:
            return Vector2(230, 230); 
            case TreeType.type2:
            return Vector2(100, 100); 
            case TreeType.type3:
            return Vector2(60, 50); 

            //kiểu cây 2
            case TreeType.type4:
            return Vector2(204, 206);
            case TreeType.type5:
            return Vector2(150, 152);
            case TreeType.type6:
            return Vector2(60, 50);//

        
            //kiểu cây 3
            case TreeType.type7:
            return Vector2(200, 248);
            case TreeType.type8:
            return Vector2(124, 112);
            case TreeType.type9:
            return Vector2(140, 178);
         
            //birt fly
            case TreeType.type10:
            return Vector2(220, 220);

            //birt fly
            case TreeType.type11:
            return Vector2(50, 50);

            case TreeType.type12:
            return Vector2(80, 80);
          }
        }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    //Chọn animation theo cây
    switch(treeType) {
      case TreeType.type1:
      animation = await _createTreeAnimation1();
      break;

      case TreeType.type2:
      animation = await _createTreeAnimation2();
      break;

      case TreeType.type3:
      animation = await _createTreeAnimation3();
      break;

      case TreeType.type4:
      animation = await _createTreeAnimation4();
      break;

      case TreeType.type5:
      animation = await _createTreeAnimation5();
      break;

      case TreeType.type6:
      animation = await _createTreeAnimation6();
      break;
    
      case TreeType.type7:
      animation = await _createTreeAnimation7();
      break;

      case TreeType.type8:
      animation = await _createTreeAnimation8();
      break;

      case TreeType.type9:
      animation = await _createTreeAnimation9();
      break;
    

      case TreeType.type10:
      animation = await _createBirdFly1();

      case TreeType.type11:
      animation = await _createfairys();

      case TreeType.type12:
      animation = await _createchest();


    }
    position = treePosition;
  }
//CÂY SỐ 1
  //Aniamtion cây 1 (Lớn)
  Future<SpriteAnimation> _createTreeAnimation1() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('tree1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tree1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tree1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tree1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tree1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tree1.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tree1.7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tree1.8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('tree1.9.png');
    sprites.add(sprite9);
    final sprite10 = await Sprite.load('tree1.10.png');
    sprites.add(sprite10);
    final sprite11 = await Sprite.load('tree1.11.png');
    sprites.add(sprite11);
    final sprite12 = await Sprite.load('tree1.12.png');
    sprites.add(sprite12);
    final sprite13 = await Sprite.load('tree1.13.png');
    sprites.add(sprite13);
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
  //Aniamtion cây 1 (Vừa)
  Future<SpriteAnimation> _createTreeAnimation2() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('tree1.1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tree1.1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tree1.1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tree1.1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tree1.1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tree1.1.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tree1.1.7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tree1.1.8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('tree1.1.9.png');
    sprites.add(sprite9);
    final sprite10 = await Sprite.load('tree1.1.10.png');
    sprites.add(sprite10);
    final sprite11 = await Sprite.load('tree1.1.11.png');
    sprites.add(sprite11);
    final sprite12 = await Sprite.load('tree1.1.12.png');
    sprites.add(sprite12);
    final sprite13 = await Sprite.load('tree1.1.13.png');
    sprites.add(sprite13);
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
  //Aniamtion cây 1 (Nhỏ)
  Future<SpriteAnimation> _createTreeAnimation3() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tree1.1.1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tree1.1.1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tree1.1.1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tree1.1.1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tree1.1.1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tree1.1.1.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tree1.1.1.7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tree1.1.1.8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('tree1.1.1.9.png');
    sprites.add(sprite9);
    final sprite10 = await Sprite.load('tree1.1.1.10.png');
    sprites.add(sprite10);
    final sprite11 = await Sprite.load('tree1.1.1.11.png');
    sprites.add(sprite11);
    final sprite12 = await Sprite.load('tree1.1.1.12.png');
    sprites.add(sprite12);
    final sprite13 = await Sprite.load('tree1.1.1.13.png');
    sprites.add(sprite13);


    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }

  Future<SpriteAnimation> _createTreeAnimation4() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tree2.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tree2.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tree2.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tree2.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tree2.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tree2.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tree2.7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tree2.8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('tree2.9.png');
    sprites.add(sprite9);
    final sprite10 = await Sprite.load('tree2.10.png');
    sprites.add(sprite10);
    final sprite11 = await Sprite.load('tree2.11.png');
    sprites.add(sprite11);
    final sprite12 = await Sprite.load('tree2.12.png');
    sprites.add(sprite12);
    final sprite13 = await Sprite.load('tree2.13.png');
    sprites.add(sprite13);
    
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }

  Future<SpriteAnimation> _createTreeAnimation5() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tree2.1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tree2.1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tree2.1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tree2.1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tree2.1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tree2.1.6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('tree2.1.7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('tree2.1.8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('tree2.1.9.png');
    sprites.add(sprite9);
    final sprite10 = await Sprite.load('tree2.1.10.png');
    sprites.add(sprite10);
    final sprite11 = await Sprite.load('tree2.1.11.png');
    sprites.add(sprite11);
    final sprite12 = await Sprite.load('tree2.1.12.png');
    sprites.add(sprite12);
    final sprite13 = await Sprite.load('tree2.1.13.png');
    sprites.add(sprite13);



      return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
  Future<SpriteAnimation> _createTreeAnimation6() async {
    final sprites = <Sprite>[];


    return SpriteAnimation.spriteList(
    sprites,
    stepTime: animationSpeed,
    loop: true,
    );
  }


  Future<SpriteAnimation> _createTreeAnimation7() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tree5.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tree5.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tree5.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tree5.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tree5.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tree5.6.png');
    sprites.add(sprite6);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
  
  Future<SpriteAnimation> _createTreeAnimation8() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tree5.1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tree5.1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tree5.1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tree5.1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tree5.1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tree5.1.6.png');
    sprites.add(sprite6);


    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
  Future<SpriteAnimation> _createTreeAnimation9() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('tree5.1.1.1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('tree5.1.1.2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('tree5.1.1.3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('tree5.1.1.4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('tree5.1.1.5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('tree5.1.1.6.png');
    sprites.add(sprite6);


    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }

  Future<SpriteAnimation> _createBirdFly1() async {
    final sprites = <Sprite>[];

    final sprite1 = await Sprite.load('bird_fly1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('bird_fly2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('bird_fly3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('bird_fly4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('bird_fly5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('bird_fly6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('bird_fly7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('bird_fly8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('bird_fly9.png');
    sprites.add(sprite9);
    final sprite10 = await Sprite.load('bird_fly10.png');
    sprites.add(sprite10);
    final sprite11 = await Sprite.load('bird_fly11.png');
    sprites.add(sprite11);
    final sprite12 = await Sprite.load('bird_fly12.png');
    sprites.add(sprite12);
    final sprite13 = await Sprite.load('bird_fly13.png');
    sprites.add(sprite13);
    final sprite14 = await Sprite.load('bird_fly14.png');
    sprites.add(sprite14);
    final sprite15 = await Sprite.load('bird_fly15.png');
    sprites.add(sprite15);
    final sprite16 = await Sprite.load('bird_fly16.png');
    sprites.add(sprite16);

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }

  Future<SpriteAnimation> _createfairys() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('fairys1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('fairys2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('fairys3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('fairys4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('fairys5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('fairys6.png');
    sprites.add(sprite6);
    final sprite7 = await Sprite.load('fairys7.png');
    sprites.add(sprite7);
    final sprite8 = await Sprite.load('fairys8.png');
    sprites.add(sprite8);
    final sprite9 = await Sprite.load('fairys9.png');
    sprites.add(sprite9);
    final sprite10 = await Sprite.load('fairys10.png');
    sprites.add(sprite10);
    final sprite11 = await Sprite.load('fairys11.png');
    sprites.add(sprite11);
    final sprite12 = await Sprite.load('fairys12.png');
    sprites.add(sprite12);


    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }

  Future<SpriteAnimation> _createchest() async {
    final sprites = <Sprite>[];
    
    final sprite1 = await Sprite.load('chest1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('chest2.png');
    sprites.add(sprite2);
    final sprite3 = await Sprite.load('chest3.png');
    sprites.add(sprite3);
    final sprite4 = await Sprite.load('chest4.png');
    sprites.add(sprite4);
    final sprite5 = await Sprite.load('chest5.png');
    sprites.add(sprite5);
    final sprite6 = await Sprite.load('chest6.png');
    sprites.add(sprite6);
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: animationSpeed,
      loop: true,
    );
  }
    
}
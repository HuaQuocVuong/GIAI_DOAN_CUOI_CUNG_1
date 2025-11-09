import 'package:flame/game.dart';
import 'package:update1/MAP/map_poisonouns_forest/animation_decor_map_poisonouns_forest.dart';

class PoisonousDecorManager {
  // DECOR CONFIGURATION - DỄ DÀNG MỞ RỘNG
  static final _decorConfigs = [
    // Format: [x, y, type, width, height]
    // Background water tĩnh

    //Base tree
    _DecorData(90, 570, GroundRocksType.type7, 142, 147), 

    _DecorData(280, 170, GroundRocksType.type7, 142, 147), //
    _DecorData(420, 190, GroundRocksType.type7, 142, 147),
    _DecorData(570, 150, GroundRocksType.type7, 142, 147), 

    _DecorData(1150, 130, GroundRocksType.type7, 142, 147), 
    _DecorData(1290, 190, GroundRocksType.type7, 142, 147), 

    _DecorData(1470, 160, GroundRocksType.type1, 150, 150),
    _DecorData(1470, 160,GroundRocksType.type3, 200, 200),
    //_DecorData(1470, 160, GroundRocksType.type7, 142, 147), 
    _DecorData(1630, 240, GroundRocksType.type7, 142, 147), 
    _DecorData(1770, 200, GroundRocksType.type7, 116, 147), 

    _DecorData(1150, 630, GroundRocksType.type7, 142, 147), 

    _DecorData(1360, 670, GroundRocksType.type1, 150, 150),
    _DecorData(1360, 670, GroundRocksType.type3, 200, 200),
  
    _DecorData(1600, 670, GroundRocksType.type7, 142, 147), 
    _DecorData(1800, 620, GroundRocksType.type7, 142, 147),

    _DecorData(90, 150, GroundRocksType.type1, 150, 150),
    _DecorData(90, 150, GroundRocksType.type3, 200, 200),

    _DecorData(300, 550, GroundRocksType.type1, 150, 150),
    _DecorData(300, 550, GroundRocksType.type3, 200, 200),

    _DecorData(300, 850, GroundRocksType.type4,  608, 216),

    _DecorData(1620, 850, GroundRocksType.type5, 608, 216),


    _DecorData(920, 140, GroundRocksType.type12, 243, 250),

    _DecorData(200, 700, GroundRocksType.type8, 440, 440),


    _DecorData(570, 630, GroundRocksType.type15, 300, 300),
    _DecorData(860, 600, GroundRocksType.type13, 300, 300),
    
    
    _DecorData(970, 893, GroundRocksType.type1, 500, 130), //
    _DecorData(740, 891, GroundRocksType.type6, 70, 138),
    _DecorData(1200, 880, GroundRocksType.type6, 78, 147),
    _DecorData(970, 890, GroundRocksType.type10, 300, 65), //


    _DecorData(843, 800, GroundRocksType.type11, 96, 83), 
    _DecorData(770, 800, GroundRocksType.type11, 96, 83),
    _DecorData(916, 800, GroundRocksType.type11, 96, 83), 
    _DecorData(989, 800, GroundRocksType.type11, 96, 83),
    _DecorData(1062, 800, GroundRocksType.type11, 96, 83), 
    _DecorData(1135, 800, GroundRocksType.type11, 96, 83),


    _DecorData(90, 150, GroundRocksType.type1, 150, 150),
    _DecorData(90, 150, GroundRocksType.type3, 200, 200),







    //_DecorData(, GroundRocksType.type7, 59, 63),
    //_DecorData(, GroundRocksType.type7, 59, 63), 
    //_DecorData(, GroundRocksType.type7, 59, 63), 
    //_DecorData(, GroundRocksType.type7, 59, 63), 
    //_DecorData(, GroundRocksType.type7, 59, 63), 

  

  ];

  // Thêm decor cho poisonous forest
  static Future<void> addDecorToGame(FlameGame game) async {

    for (final config in _decorConfigs) {


      final decor = GroundRocksComponent(
        rockPosition: Vector2(config.x, config.y),
        rockType: config.type,
        animationSpeed: _getAnimationSpeed(config.type),
        size: Vector2(config.width, config.height),
      )..priority = _getPriority(config.type);

      await game.add(decor);

    }
  }

  // Xác định animation speed theo loại
  static double _getAnimationSpeed(GroundRocksType type) {
    switch (type) {
      case GroundRocksType.type1: // Background tĩnh
        return 0.1;
      case GroundRocksType.type2: // Animation nước động
        return 0.1;
      case GroundRocksType.type3:
        return 0.1;
      case GroundRocksType.type4:
        return 0.1;
      case GroundRocksType.type5:
        return 0.1;

      //Stone
      case GroundRocksType.type6:
        return 0.1;
      case GroundRocksType.type7:
        return 0.1;
      case GroundRocksType.type8:
        return 0.1;

      //Water 
      case GroundRocksType.type10:
        return 0.1;
      case GroundRocksType.type11:
        return 0.1;
      case GroundRocksType.type12:
        return 0.1;
      case GroundRocksType.type13:
        return 0.1;

      case GroundRocksType.type15:
        return 0.1;
      
    }
  }

  // Xác định priority theo loại
  static int _getPriority(GroundRocksType type) {
    switch (type) {
      case GroundRocksType.type1: // Background 
        return -1; // Vẽ phía sau
      case GroundRocksType.type2: 
        return -1;
      case GroundRocksType.type3:
        return -1;

      //Background
      case GroundRocksType.type4:
          return -1;
      case GroundRocksType.type5:
          return -1;



      //Stone   
      case GroundRocksType.type6:
          return -1;
      //base tree
      case GroundRocksType.type7:
          return -1;

      case GroundRocksType.type8:
          return -1;

      case GroundRocksType.type10:
        return -1;
      case GroundRocksType.type11:
        return -1;
      case GroundRocksType.type12:
        return -1;
      case GroundRocksType.type13:
        return -1;


      case GroundRocksType.type15:
        return -1;
    }
  }

  // Xóa decor khỏi poisonous forest
  static Future<void> removeDecorFromGame(FlameGame game) async {
    final rocks = game.children.whereType<GroundRocksComponent>().toList();
    for (final rock in rocks) {
      rock.removeFromParent();
    }
  }
}

// CLASS PHỤ TRỢ - Đơn giản hóa việc khai báo
class _DecorData {
  final double x;
  final double y;
  final GroundRocksType type;
  final double width;
  final double height;

  _DecorData(this.x, this.y, this.type, this.width, this.height);
}
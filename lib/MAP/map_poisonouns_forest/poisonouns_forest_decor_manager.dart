import 'package:flame/game.dart';
import 'package:update1/MAP/map_poisonouns_forest/animation_decor_map_poisonouns_forest.dart';

class PoisonousDecorManager {
  // DECOR CONFIGURATION - DỄ DÀNG MỞ RỘNG
  static final _decorConfigs = [
    // Format: [x, y, type, width, height]
    // Background water tĩnh
    _DecorData(90, 150, GroundRocksType.type1, 150, 150),
    _DecorData(90, 150, GroundRocksType.type3, 200, 200),

    _DecorData(300, 550, GroundRocksType.type1, 150, 150),
    _DecorData(300, 550, GroundRocksType.type3, 200, 200),

    _DecorData(300, 850, GroundRocksType.type4,  608, 216),

    _DecorData(1620, 850, GroundRocksType.type5, 608, 216),



    
    _DecorData(970, 870, GroundRocksType.type1, 500, 180),
    _DecorData(740, 891, GroundRocksType.type6, 70, 138),
    _DecorData(1200, 880, GroundRocksType.type6, 78, 147),
    _DecorData(970, 870, GroundRocksType.type10, 70, 12),

    

    



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
    

      //Water 
      case GroundRocksType.type10:
        return 0.1;
      case GroundRocksType.type11:
        return 0.1;
      case GroundRocksType.type12:
        return 0.1;

      
      
    }
  }

  // Xác định priority theo loại
  static int _getPriority(GroundRocksType type) {
    switch (type) {
      case GroundRocksType.type1: // Background - vẽ trước
        return -1;
      case GroundRocksType.type2: // Animation - vẽ sau
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
   



      case GroundRocksType.type10:
        return -1;
      case GroundRocksType.type11:
        return -1;
      case GroundRocksType.type12:
        return -1;
    }
  }

  // Remove decor
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
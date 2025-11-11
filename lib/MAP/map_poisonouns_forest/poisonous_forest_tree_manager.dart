import 'package:flame/game.dart';

import 'package:update1/MAP/tree_manager_base.dart';

import 'package:update1/MAP/tree_animation.dart';

// Quản lý cây, vị trí cây trong khu rừng độc (Poisonous Forest)
// Kế thừa từ TreeManagerBase và triển khai logic cụ thể cho map Poisonous Forest
class PoisonousForestTreeManager extends TreeManagerBase {
  @override
  Future<void> addTreesToGame(FlameGame game) async {
    // Danh sách cấu hình cây cho map Poisonous Forest
    final trees = [ 

       // Khu vực trên góc trái map
      TreeConfig(position: Vector2(120, 600), type: TreeType.type7),

      // Khu vực giữa trên - cụm cây ngang qua map
      TreeConfig(position: Vector2(280, 200), type: TreeType.type9),
      TreeConfig(position: Vector2(450, 220), type: TreeType.type8),
      TreeConfig(position: Vector2(600, 180), type: TreeType.type7),
      
      // Khu vực trên góc phải map
      TreeConfig(position: Vector2(1180, 160), type:TreeType.type7),
      TreeConfig(position: Vector2(1320, 220), type:TreeType.type8),
      TreeConfig(position: Vector2(1650, 270), type:TreeType.type7),
      TreeConfig(position: Vector2(1800, 230), type:TreeType.type9),

      // Khu vực giữa - bên phải map
      TreeConfig(position: Vector2(1180, 660), type: TreeType.type9),

      //TreeConfig(position: Vector2(1390, 700), type: TreeType.type9),
      TreeConfig(position: Vector2(1630, 700), type: TreeType.type7),
      TreeConfig(position: Vector2(1830, 650), type: TreeType.type7),
      
      //TreeConfig(position: Vector2(X, Y), type: TreeType.typeN),
    ];
    // Duyệt qua từng cấu hình và tạo TreeComponent tương ứng
    for (final config in trees) {
      final tree = TreeComponent(
        treePosition: config.position,  // Vị trí cây trên map
        treeType: config.type,  // Loại cây (type7, type8, type9)
        animationSpeed: 0.5,   // Tốc độ animation (chậm - phù hợp forest)
      );
      // Thêm cây vào game (await để đảm bảo thứ tự)
      await game.add(tree);
    }
  }

  @override
  Future<void> removeTreesFromGame(FlameGame game) async {
    // Sử dụng implementation mặc định từ base class
    // Gọi removeAllTrees() để xóa tất cả TreeComponent khỏi game
    await removeAllTrees(game);
  }
}
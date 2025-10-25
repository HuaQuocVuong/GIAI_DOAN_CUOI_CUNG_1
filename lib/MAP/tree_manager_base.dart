import 'package:flame/game.dart';

import 'package:update1/MAP/tree_animation.dart';

// Abstract class quản lý cây trong game - dùng abstract để định nghĩa interface
abstract class TreeManagerBase {
  // Phương thức abstract - các class con phải triển khai
  // Thêm cây vào game (vị trí, số lượng do class con quyết định)
  Future<void> addTreesToGame(FlameGame game);


  // Phương thức cụ thể với implementation mặc định
  // Xóa tất cả cây khỏi game - có thể được ghi đè nếu cần
  Future<void> removeTreesFromGame(FlameGame game) async {
    await removeAllTrees(game);
  }
  
  // Phương thức helper để xóa tất cả TreeComponent khỏi game
  Future<void> removeAllTrees(FlameGame game) async {

    // Tìm tất cả components có type là TreeComponent trong game
    final trees = game.children.whereType<TreeComponent>().toList();
    
    // Duyệt qua từng cây và xóa khỏi parent (game)
    for (final tree in trees) {
      tree.removeFromParent();
    }
  }
}

// Class cấu hình cho cây - lưu thông tin vị trí và loại cây
class TreeConfig {
  final Vector2 position; // Vị trí cây trong game  (x, y)
  final TreeType type;  // Loại cây (enum định nghĩa các loại cây khác nhau)
  TreeConfig({
    required this.position, 
    required this.type
   
  });
}
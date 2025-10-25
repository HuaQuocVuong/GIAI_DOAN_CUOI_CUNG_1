import 'package:flame/game.dart';

import 'package:update1/MAP/tree_manager_base.dart';

import 'package:update1/MAP/tree_animation.dart';



class ForestTreeManager extends TreeManagerBase {
  @override
  Future<void> addTreesToGame(FlameGame game) async {
    final trees = [
      // Khu vực trên góc trái map
      TreeConfig(position: Vector2(100, 260), type: TreeType.type1),
      TreeConfig(position: Vector2(100, 200), type: TreeType.type10),


      TreeConfig(position: Vector2(240, 160), type: TreeType.type2),

      TreeConfig(position: Vector2(380, 260), type: TreeType.type1),
      TreeConfig(position: Vector2(380, 260), type: TreeType.type10),

      TreeConfig(position: Vector2(520, 280), type: TreeType.type2),

      TreeConfig(position: Vector2(600, 200), type: TreeType.type1),
      TreeConfig(position: Vector2(600, 200), type: TreeType.type10),

      //TreeConfig(position: Vector2(640, 250), type: TreeType.type3),
      TreeConfig(position: Vector2(750, 320), type: TreeType.type2),

      TreeConfig(position: Vector2(800, 220), type: TreeType.type1),
      TreeConfig(position: Vector2(800, 220), type: TreeType.type10),
      TreeConfig(position: Vector2(800, 190), type: TreeType.type10),

      // Khu vực trên góc phải map
      TreeConfig(position: Vector2(1120, 170), type: TreeType.type5),//1
       TreeConfig(position: Vector2(1120, 170), type: TreeType.type10),

      TreeConfig(position: Vector2(1310, 220), type: TreeType.type4),
       TreeConfig(position: Vector2(1310, 220), type: TreeType.type10),

      TreeConfig(position: Vector2(1500, 190), type: TreeType.type5),
       TreeConfig(position: Vector2(1500, 190), type: TreeType.type10),

      TreeConfig(position: Vector2(1720, 240), type: TreeType.type4),
       TreeConfig(position: Vector2(1720, 240), type: TreeType.type10),
      //TreeConfig(position: Vector2(1800, 230), type: TreeType.type4),
      
      // Khu vực giữa - trung tâm
      TreeConfig(position: Vector2(100, 600), type: TreeType.type1),

      //TreeConfig(position: Vector2(240, 550), type: TreeType.type3),
      TreeConfig(position: Vector2(200, 700), type: TreeType.type2),

      TreeConfig(position: Vector2(450, 700), type: TreeType.type1),
      TreeConfig(position: Vector2(720, 730), type: TreeType.type2),
      TreeConfig(position: Vector2(870, 750), type: TreeType.type1),

      

      // Khu vực giữa - bên phải map
      TreeConfig(position: Vector2(1180, 660), type: TreeType.type5),
      TreeConfig(position: Vector2(1180, 660), type: TreeType.type10),
      TreeConfig(position: Vector2(1390, 700), type: TreeType.type4),
      TreeConfig(position: Vector2(1630, 700), type: TreeType.type4),
      TreeConfig(position: Vector2(1830, 650), type: TreeType.type5),
    ];

    for (final config in trees) {
      final tree = TreeComponent(
        treePosition: config.position,
        treeType: config.type,
        animationSpeed: 0.5,
      );
      await game.add(tree);
    }
  }

  @override
  Future<void> removeTreesFromGame(FlameGame game) async {
    await removeAllTrees(game);
  }
}
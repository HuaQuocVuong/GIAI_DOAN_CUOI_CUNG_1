import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';


import 'package:update1/player/player_controller.dart';

import 'package:update1/Lining/spawn_lining_manager.dart';

import 'package:update1/MAP/map_manager.dart';
import 'package:update1/MAP/tree_manager_base.dart';
import 'package:update1/MAP/status_maps/map_status.dart';
import 'package:update1/MAP/tree_animation.dart';

import 'package:update1/player/handlings_player.dart';

import 'package:update1/boss_S1/handlings_boss1.dart';
import 'package:update1/boss_S1/animation_boss.dart';
import 'package:update1/boss_S1/health_bar_is_boss.dart';

import 'package:update1/boss_S2/handlings_boss2.dart';
import 'package:update1/boss_S2/animation_boss2.dart';

//Lớp MyGame là lớp chính của game.
//Kế thừa từ FlameGame quản lý toàn bộ vòng đời, render, update
//Mixin HasCollisionDetection cho phép va chạm giữa các đối tượng (Bullet vs Target)
class MyGame extends FlameGame with HasCollisionDetection ,HasKeyboardHandlerComponents {
  late PlayerTank player;            // người chơi
  late PlayerController playerController; // Controller xử lý input
  late DangerZoneSpawner dangerZoneSpawner; // Thêm spawn 
  late MapManager mapManager;

  @override
  Future<void> onLoad() async {
    super.onLoad(); // Hàm onLoad(): chạy một lần khi game bắt đầu.

    mapManager = MapManager(this);

    // Sử dụng MapTreeManager để thêm cây
     await mapManager.switchMap(GameMapType.forest); // Load map đầu tiên

    // Tạo và thêm người chơi vào màn hình
    player = PlayerTank();
    await add(player);

    // Gắn controller và thêm TapCallbacks trừu tượng: ẩn input handling
    playerController = PlayerController(player: player, game: this);
    add(playerController);

    // Thêm danger spawn tạo ra vùng nguy hiểm (Sau sẽ chèn thành sấm sét yếu tố tự nhiên gây sát thương cho nhân vật)
    dangerZoneSpawner = DangerZoneSpawner(spawnInterval: 5.0);
    add(dangerZoneSpawner); 
  }
   // THÊM HÀM NÀY ĐỂ CHUYỂN MAP
  Future<void> changeMap(GameMapType newMap) async {
    await mapManager.switchMap(newMap);
  }
}
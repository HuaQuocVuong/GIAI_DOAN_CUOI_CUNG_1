import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:update1/player/handlings_player.dart';

// Import các component
import 'package:update1/player/player_controller.dart';
import 'package:update1/Lining/spawn_lining_manager.dart';
import 'package:update1/MAP/map_manager.dart';
// ... các import khác
import 'package:update1/processing_function/pause_menu.dart';

class MyGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  // Game components
  late PlayerTank player;
  late PlayerController playerController;
  late DangerZoneSpawner dangerZoneSpawner;
  late MapManager mapManager;
  
  // Menu system
  late PauseMenu pauseMenu;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Khởi tạo các component game
    mapManager = MapManager(this);
    await mapManager.switchMap(GameMapType.forest);

    player = PlayerTank();
    await add(player);

    playerController = PlayerController(player: player, game: this);
    add(playerController);

    dangerZoneSpawner = DangerZoneSpawner(spawnInterval: 5.0);
    add(dangerZoneSpawner);

    // Khởi tạo pause menu
    pauseMenu = PauseMenu(game: this);
    _setupKeyboardListener();
    
  }

  void _setupKeyboardListener() {
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
      togglePauseMenu();
      return true;
    }
    return false;
  }

  // HÀM NÀY CẦN ĐƯỢC PUBLIC ĐỂ NÚT PAUSE CÓ THỂ GỌI
  void togglePauseMenu() {
    pauseMenu.toggleMenu();
  }

  @override
  void onRemove() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    super.onRemove();
  }

  Future<void> changeMap(GameMapType newMap) async {
    await mapManager.switchMap(newMap);
  }
}
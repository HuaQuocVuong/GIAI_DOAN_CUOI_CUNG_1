import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flame/events.dart';
import 'package:flame/input.dart';

import 'package:flutter/services.dart';

import 'package:update1/player/handlings_bullets_player.dart';
import 'package:update1/player/handlings_player.dart';
import 'package:update1/player/click_marker.dart';

import 'package:update1/MAP/map_manager.dart';
import 'package:update1/processing_function/my_game.dart';

//Lớp PlayerController: xử lý input tap của người chơi
//Kế thừa PositionComponent
//Sử dụng KeyboardHandler để xử lý sự kiện bàn phím
//Sử dụng TapCallbacks để xử lý sự kiện chạm (tap)
class PlayerController extends PositionComponent with KeyboardHandler ,TapCallbacks {
  final PlayerTank player; // Tham chiếu đến người chơi 
  final FlameGame game;    // Tham chiếu tới game instance

  
  // Biến để theo dõi trạng thái các phím
  bool _isWPressed = false;
  bool _isSPressed = false;
  bool _isAPressed = false;
  bool _isDPressed = false;

  PlayerController({required this.player, required this.game}) {
    size = game.size;
    position = Vector2.zero();
  }
  
  // Hàm xử lý sự kiện bàn phím
  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // XỬ LÝ CHUYỂN MAP TRƯỚC
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.digit1) {
        _changeMap(GameMapType.forest);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.digit2) {
        _changeMap(GameMapType.poisonousforest);
        return true;
      }
    }
    
    // Cập nhật trạng thái các phím
    _isWPressed = keysPressed.contains(LogicalKeyboardKey.keyW);  //Đi lên
    _isSPressed = keysPressed.contains(LogicalKeyboardKey.keyS);  //Đi xuống
    _isAPressed = keysPressed.contains(LogicalKeyboardKey.keyA);  //Đi trái
    _isDPressed = keysPressed.contains(LogicalKeyboardKey.keyD);  //Đi phải

    // Tính hướng di chuyển dựa trên các phím được nhấn
    Vector2 direction = Vector2.zero();
    
    if (_isWPressed) direction.y -= 1; // Lên
    if (_isSPressed) direction.y += 1; // Xuống
    if (_isAPressed) direction.x -= 1; // Trái
    if (_isDPressed) direction.x += 1; // Phải

    // Chuẩn hóa vector hướng nếu đang di chuyển
    if (direction != Vector2.zero()) {
      direction.normalize();
    }

    // Gọi phương thức di chuyển của player
    player.moveWithKeys(direction);

    return true; // Đánh dấu sự kiện đã được xử lý
  }

  // HÀM CHUYỂN MAP
  void _changeMap(GameMapType mapType) {
    // Kiểm tra nếu game có hỗ trợ chuyển map
    if (game is MyGame) {
      final myGame = game as MyGame;
      myGame.changeMap(mapType);
    }
  }

  // Hàm onTapDown(): gọi khi người chơi click chuột vào màn hình
  @override
  void onTapDown(TapDownEvent event) {
    // KIỂM TRA ĐIỀU KIỆN - chỉ xử lý nếu player có thể hành động
    if (player.isDead || player.isRespawning || player.isAttacking) {
      return;
    }

    final Vector2 tapPosition = event.canvasPosition; // Lấy vị trí tap của người chơi
    
    // Xử lý bắn đạn
    _handleShooting(tapPosition);

    // Hiệu ứng và âm thanh
    _playEffects(tapPosition);

    // Tính hướng và truyền vào attack
    final Vector2 attackDirection = (tapPosition - player.position).normalized();
    player.attack(attackDirection);
  }

  /// Xử lý bắn đạn
  void _handleShooting(Vector2 tapPosition) {
    // Vector hướng bắn = (vị trí tap - vị trí người chơi).normalized()
    final Vector2 direction = (tapPosition - player.position).normalized();
    final bool isFacingRight = direction.x >= 0;   // Xác định hướng quay
    
    final Vector2 bulletPosition = player.position;
    
    // Tạo viên đạn mới
    final Bullet bullet = Bullet(
      position: bulletPosition, // Vị trí xuất phát
      direction: direction,     // Hướng bay
      isFacingRight: isFacingRight, // Truyền tham số hướng
    );

    // Thêm vào game để render + update
    game.add(bullet);
  }
  /// Phát hiệu ứng và âm thanh
  void _playEffects(Vector2 tapPosition) {
    // Hiện ClickMarker tại vị trí click (hiệu ứng nhấp chuột)
    final marker = ClickMarker(tapPosition, player.size.x / 2);
    game.add(marker);
  }
}
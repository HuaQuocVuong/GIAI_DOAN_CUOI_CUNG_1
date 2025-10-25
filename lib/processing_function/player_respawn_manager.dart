import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:update1/player/components_player.dart';


/// Quản lý hồi sinh cho PlayerTank - ĐÓNG GÓI toàn bộ logic hồi sinh
class PlayerRespawnManager extends Component with HasGameRef {
  final PlayerTank player;
  
  // Biến quản lý trạng thái hồi sinh
  bool _isRespawning = false;
  int _respawnCount = 0; // Đếm số lần đã hồi sinh
  static const int maxRespawnCount = 2; // Số lần hồi sinh tối đa

  PlayerRespawnManager({required this.player});

  // Bắt đầu quá trình hồi sinh
  void startRespawn() {

    // Kiểm tra nếu đã hết số lần hồi sinh
    if (_respawnCount >= maxRespawnCount) {
      return; // Không cho hồi sinh nữa
    }
       // Đảm bảo restet trạng thái chết trước khi hồi sinh 
    if (player.isMounted) return;
    _isRespawning = true;
    _respawnCount++; // Tăng số lần đã hồi sinh
     gameRef.add(player);
     // Hẹn giờ hoàn thành hồi sinh sau x giây
     Future.delayed(const Duration(seconds: 5), _completeRespawn);
  }

  /// Hồi sinh player - khôi phục toàn bộ trạng thái
  void _completeRespawn() {

    // Kiểm tra an toàn: chỉ hồi sinh nếu đang trong trạng thái hồi sinh
    if (!_isRespawning) {
      return;
    }

    // Đảm bảo player vẫn được gắn vào game
    _isRespawning = false;
    if (player.isMounted) {
      player.resetDeathState();
      // Khôi phục máu đầy trở lại 
      player.currentHealth = player.maxHealth;
      
      // Hiện nhân vật
      player.tank.paint.color = player.tank.paint.color.withOpacity(1.0);
    
      // Đặt lại vị trí về giữa màn hình
      player.position = Vector2(100, 280);
      player.targetPosition = player.position.clone();

    }
    FlameAudio.play('PlayerGood1.mp3'); //Âm thanh hồi sinh 
  }
  

  // GETTERS để truy cập trạng thái từ bên ngoài
  

  bool get canRespawn => _respawnCount < maxRespawnCount; // Kiểm tra xem còn có thể hồi sinh không
  int get remainingRespawns => maxRespawnCount - _respawnCount; // Get số lần hồi sinh còn lại
  int get respawnCount => _respawnCount;  // Get số lần đã hồi sinh
  bool get isRespawning => _isRespawning; /// Kiểm tra đang trong quá trình hồi sinh
  bool get canPlayerAct => !_isRespawning;  /// Kiểm tra player có thể hành động không
  double get respawnProgress => 1.0;  /// Tiến trình hồi sinh (luôn 1.0 - hoàn thành ngay lập tức)
  double get remainingRespawnTime => 0.0;  /// Thời gian hồi sinh còn lại (luôn 0.0 - không có delay)
}
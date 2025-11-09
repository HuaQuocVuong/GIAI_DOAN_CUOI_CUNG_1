import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:update1/Lining/animation_lining.dart';
import 'package:update1/Lining/handlings_lining.dart';

import 'package:update1/Lining/spawn_lining_manager.dart';
import 'package:update1/processing_function/my_game.dart';

import 'package:update1/player/handlings_player.dart';

class DangerZoneSpawner extends Component with HasGameRef<MyGame> {
  final double spawnInterval; //Khoảng thời gian spawn tính theo giây
  double _timer = 0; //Bộ đếm thời gian tích lũy
  
  // Constructor với giá trị mặc định 2 giây spawn một lần
  DangerZoneSpawner({this.spawnInterval = 0.5});

  @override
  void update(double dt) {
    super.update(dt);
    
    _timer += dt; //Tích lũy thời gian delta-time

    if (_timer >= spawnInterval) {
      _spawnDangerZone();  //Gọi spawn Lining khi đủ thời gian
      _timer = 0; //Reset bộ đếm về 0 bắt đầu lại
    }
  }

  //Spawn DangerZone tại vị trí ngẫu nhiên -> Trừu tượng
  // Phương thức private ẩn đi logic spawn phức tạp, chỉ expose interface đơn giản
  void _spawnDangerZone() {
    final random = Random(); //Tạo generator ngẫu nhiên

    
    // Random ngẫu nhiên theo chiều ngang và cố định chiều dọc để phù hợp với animation
    //randomX: từ 150 đến (chiều rộng game - 300) để tránh spawn sát mép trái/phải
    final randomX = 150 + random.nextDouble() * (gameRef.size.x - 300); // Tránh mép trái phải
    final startY = 280; // Sát trên cùng màn hình
    

   
    // Lining có thể là nhiều loại khác nhau
    final dangerZone = DangerZone(
      position: Vector2(randomX, startY as double ),
      lightningType: LightningType.type1, // CHỈ CÓ TYPE1
      damageAmount: 30, //Gây 10 sát thương mỗi lần
      lifeTime: 3, // Tồn tại trong 3 giây
    );

    // Thêm DangerZone vào game như một component độc lập
    // Sử dụng composition để quản lý đối tượng ko kế thừa
    gameRef.add(dangerZone);

    // Phát âm thanh khi spawn lightning
    FlameAudio.play('snoud_lining.mp3');
  }
}
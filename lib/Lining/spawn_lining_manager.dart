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
  final double spawnInterval;
  final double delayLightning2;
  final double delayLightning3;
  double _timer = 0;

  DangerZoneSpawner({
    this.spawnInterval = 0.5, 
    this.delayLightning2 = 0.3,
    this.delayLightning3 = 0.6,
  });

  @override
  void update(double dt) {
    super.update(dt);
    
    _timer += dt;

    if (_timer >= spawnInterval) {
      _spawnDangerZones();
      _timer = 0;
    }
  }

  void _spawnDangerZones() {
    final random = Random();
    final List<double> usedPositions = [];
   
    // Spawn sấm sét thứ nhất
    final randomX1 = 150 + random.nextDouble() * (gameRef.size.x - 300);
    usedPositions.add(randomX1);

    final dangerZone1 = DangerZone(
      position: Vector2(randomX1, 280),
      lightningType: LightningType.type1,
      damageAmount: 30,
      lifeTime: 3,
    );
    gameRef.add(dangerZone1);
    FlameAudio.play('snoud_lining.mp3');

    // SPAWN SẤM SÉT THỨ HAI - TYPE2 (SAU DELAY)
    Future.delayed(Duration(milliseconds: (delayLightning2 * 1000).round()), () {
      double randomX2;
      do {
        randomX2 = 150 + random.nextDouble() * (gameRef.size.x - 300);
      } while ((randomX2 - randomX1).abs() < 250);
      usedPositions.add(randomX2);

      final dangerZone2 = DangerZone(
        position: Vector2(randomX2, 280),
        lightningType: LightningType.type2,
        damageAmount: 30,
        lifeTime: 3,
      );
      gameRef.add(dangerZone2);
      FlameAudio.play('snoud_lining.mp3');
    });

    // SPAWN SẤM SÉT THỨ BA - TYPE3 (SAU DELAY) - ĐÃ SỬA LỖI
    Future.delayed(Duration(milliseconds: (delayLightning3 * 1000).round()), () {
      double randomX3;
      do {
        randomX3 = 150 + random.nextDouble() * (gameRef.size.x - 300);
      } while (usedPositions.any((pos) => (pos - randomX3).abs() < 250));

      final dangerZone3 = DangerZone(
        position: Vector2(randomX3, 280),
        lightningType: LightningType.type3,
        damageAmount: 30,
        lifeTime: 3,
      );
      gameRef.add(dangerZone3);
      FlameAudio.play('snoud_lining.mp3');
    });
  }
} 
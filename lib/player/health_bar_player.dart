import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:update1/player/components_player.dart';

/// Thanh máu cho PlayerTank - sử dụng ảnh sprite
class HealthBar extends PositionComponent {
  final PlayerTank tank;
  bool _spritesLoaded = false;
  late Sprite _currentHealthSprite;

  // Các sprite cho từng mức máu
  late final Sprite _health100;
  late final Sprite _health75;
  late final Sprite _health50;
  late final Sprite _health25;
  late final Sprite _health0;

  HealthBar({required this.tank}) : super(
    size: Vector2(150, 82), // Kích thước của ảnh health bar
    anchor: Anchor.topCenter,
  );

  // Phương thức tải tất cả sprite
  Future<void> loadHealthSprites() async {
    _health100 = await Sprite.load('healthbar1.png');
    _health75 = await Sprite.load('healthbar2.png');
    _health50 = await Sprite.load('healthbar3.png');
    _health25 = await Sprite.load('healthbar4.png');
    _health0 = await Sprite.load('healthbar5.png');
    
    _currentHealthSprite = _health100;
    _spritesLoaded = true;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (tank.isMounted && _spritesLoaded) {
      // Cập nhật sprite theo máu hiện tại
      _updateHealthSprite();
      
      // Vẽ sprite máu - CHỈ VẼ ẢNH, KHÔNG VẼ THANH MÁU CŨ
      _currentHealthSprite.render(canvas, size: size);
    }
    // Nếu chưa tải được sprite thì không vẽ gì cả
  }

  // Cập nhật sprite theo tỉ lệ máu
  void _updateHealthSprite() {
    final healthRatio = tank.currentHealth / tank.maxHealth;
    
    if (healthRatio > 0.8) {
      _currentHealthSprite = _health100;
    } else if (healthRatio > 0.6) {
      _currentHealthSprite = _health75;
    } else if (healthRatio > 0.4) {
      _currentHealthSprite = _health50;
    } else if (healthRatio > 0.1) {
      _currentHealthSprite = _health25;
    } else {
      _currentHealthSprite = _health0;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (tank.isMounted) {
      position = Vector2(0, -tank.size.y / 2 - 70);
    }
  }
}
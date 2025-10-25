import 'package:flame/collisions.dart';
import 'package:flame/components.dart';


import 'package:update1/processing_function/my_game.dart';

import 'package:update1/Lining/animation_lining.dart';

import 'package:update1/player/components_player.dart';

class DangerZone extends SpriteAnimationComponent 
    with HasGameRef<MyGame>, CollisionCallbacks {
  
  final double damageAmount;
  final double lifeTime;
  final LightningType lightningType;
  
  double _lifeTimer = 0;
  PlayerTank? _currentPlayer;

  DangerZone({
    required Vector2 position,
    required this.lightningType,
    this.damageAmount = 20,
    this.lifeTime = 8.0,
  }) : super(
          position: position,
          size: Vector2(300, 600), //Kích thước 
          
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Load animation
    animation = await LightningAnimationManager.getAnimationByType(lightningType);
    
    // Thêm hitbox va chạm với người chơi
    add(RectangleHitbox(
      size: Vector2(250, 150), //hitbox
      position: Vector2(165, 518), 
      anchor: Anchor.center,
    )..collisionType = CollisionType.active);
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Quản lý thời gian tồn tại
    _lifeTimer += dt;
    if (_lifeTimer >= lifeTime) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    
    if (other is PlayerTank) {
      _currentPlayer = other;
      _applyDamage(); // Gây sát thương ngay khi va chạm
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    
    if (other is PlayerTank) {
      _currentPlayer = null;
    }
  }

  void _applyDamage() {
    if (_currentPlayer != null && 
        _currentPlayer!.isMounted && 
        _currentPlayer!.isAlive) {
      _currentPlayer!.takeDamage(damageAmount.toInt());
    }
  }
}
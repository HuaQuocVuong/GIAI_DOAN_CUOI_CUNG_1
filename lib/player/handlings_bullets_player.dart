import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

import 'package:update1/processing_function/my_game.dart';

import 'package:update1/player/animation_bullet_player.dart';

import 'package:update1/boss_S1/handlings_boss1.dart';

class Bullet extends SpriteAnimationComponent 
    with HasGameRef<MyGame>, CollisionCallbacks {
  final Vector2 direction;
  final double speed = 1000; 
  double _lifeTime = 0.0;
  static const double _stuckThreshold = 0.5;
  double _stuckTime = 0.0;
  bool _hasMoved = false;

  final double damage = 80; //Dame bullet

  late BulletAnimations animations; // THÊM ANIMATIONS
  final bool isFacingRight; // THÊM BIẾN XÁC ĐỊNH HƯỚNG
  
  
  Bullet({
    required Vector2 position,
    required this.direction,
    required this.isFacingRight,
  }) : 
  super(
    anchor: Anchor.center,
    position: position + (isFacingRight ? Vector2(0, 0) : Vector2(-50, 0)),
    size: Vector2(120, 120), // Kích thước cho animation
  ) {
    add(CircleHitbox(
      radius: 25, //Bán kính viên đạn
      anchor: Anchor.center,
      position: Vector2(60, 60),
    ) ..collisionType = CollisionType.passive);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    //KHỞI TẠO VÀ TẢI ANIMATION
    animations = BulletAnimations();
    await animations.loadAllAnimations();
    
    //SET ANIMATION THEO HƯỚNG
    animation = animations.getFlyAnimation(isFacingRight);

  }
  
  @override
  void update(double dt) {
    super.update(dt);

    _lifeTime += dt;
    
    // THÊM ĐIỀU KIỆN KIỂM TRA THỜI GIAN TỒN TẠI
    if (_lifeTime > 5.0) { // Tự động xóa sau 5 giây
      removeFromParent();
      return;
    }
    final Vector2 previousPosition = position.clone();
  
    // DI CHUYỂN ĐẠN
    position += direction.normalized() * speed * dt;

    final double distanceMoved = (position - previousPosition).length;

    if (distanceMoved > 0.1) {
      _hasMoved = true;
      _stuckTime = 0.0;
    } else if (_hasMoved) {
      _stuckTime += dt;
    }

    
    if (_isOutOfBounds() || (_hasMoved && _stuckTime >= _stuckThreshold)) {
      removeFromParent();
    }
  }

  bool _isOutOfBounds() {
    final margin = 50.0;
    return position.x < -margin || position.x > gameRef.size.x + margin ||
           position.y < -margin || position.y > gameRef.size.y + margin;
  }
  // THÊM XỬ LÝ VA CHẠM VỚI BOSS
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints, 
    PositionComponent other
  ) {
    super.onCollisionStart(intersectionPoints, other);
    
    // Nếu va chạm với Boss
    if (other is Boss && other.isAlive) {
      _hitBoss(other);
    }
  }
  void _hitBoss(Boss boss) {
    // Gây sát thương cho boss
    boss.takeDamage(damage);
    
    // Tạo hiệu ứng nổ/impact
    //_createImpactEffect();
    
    // Xóa viên đạn
    removeFromParent();
  }
  
}


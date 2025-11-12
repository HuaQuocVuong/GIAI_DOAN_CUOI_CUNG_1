import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'package:update1/processing_function/my_game.dart';

import 'package:update1/player/animation_bullet_player.dart';

import 'package:update1/boss_S1/handlings_boss1.dart';
import 'package:update1/boss_S2/handlings_boss2.dart';

class Bullet extends SpriteAnimationComponent 
    with HasGameRef<MyGame>, CollisionCallbacks {
  final Vector2 direction;
  final double speed = 1000; //Tốc độ đạn default:1000
  double _lifeTime = 0.0;
  static const double _stuckThreshold = 0.5;
  double _stuckTime = 0.0;
  bool _hasMoved = false;
  bool _hasHit = false;

  final double damage = 35; //Dame bullet 3x

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
    //FlameAudio.play('skill2.mp3');
    //FlameAudio.play('swordhit1.mp3');
    
    //SET ANIMATION THEO HƯỚNG
    animation = animations.getFlyAnimation(isFacingRight);

  }
  
  @override
  void update(double dt) {
    super.update(dt);

    if (_hasHit) return;

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
    
    if (_hasHit) return; // ĐÃ TRÚNG RỒI THÌ BỎ QUA

     // THÊM KIỂM TRA CHO BOSS2
    if (other is Boss && other.isAlive) {
      _hitBoss1(other);
    } else if (other is Boss2 && other.isAlive) {
      _hitBoss2(other);
    }
  }
  void _hitBoss1(Boss boss) {
    if (_hasHit) return;
    
    _hasHit = true;
    
    // GÂY SÁT THƯƠNG CHO BOSS
    boss.takeDamage(damage);
    
    // HIỆU ỨNG NỔ
    _playHitEffect();
  }

   void _hitBoss2(Boss2 boss) {
    if (_hasHit) return;
    
    _hasHit = true;
    
    // GÂY SÁT THƯƠNG CHO BOSS2
    boss.takeDamage(damage);
    
    // HIỆU ỨNG NỔ
    _playHitEffect();
  }


  // PHÁT HIỆU ỨNG NỔ
  void _playHitEffect() {
    // CHỌN ANIMATION NỔ THEO HƯỚNG
    if (isFacingRight) {
      animation = animations.bulletHitRight;
    } else {
      animation = animations.bulletHitLeft;
    }
    
    // DỪNG DI CHUYỂN
    _hasHit = true;
    
    // LOẠI BỎ HITBOX ĐỂ TRÁNH VA CHẠM TIẾP
    for (final component in children.toList()) {
      if (component is Hitbox) {
        remove(component);
      }
    }
    
    // TỰ ĐỘNG XÓA SAU KHI ANIMATION NỔ KẾT THÚC
    final effectDuration = _calculateHitEffectDuration();
    add(RemoveEffect(delay: effectDuration));
  }

  // TÍNH THỜI GIAN HIỆU ỨNG NỔ
  double _calculateHitEffectDuration() {
    try {
      if (animation == null || animation!.frames.isEmpty) return 0.25;
      
      double totalDuration = 0;
      for (final frame in animation!.frames) {
        totalDuration += frame.stepTime;
      }
      return totalDuration;
    } catch (e) {
      return 0.25;
    }
  }

  // PHƯƠNG THỨC AN TOÀN ĐỂ REMOVE
  void safeRemove() {
    if (!_hasHit) {
      _playHitEffect();
    }
  }
}


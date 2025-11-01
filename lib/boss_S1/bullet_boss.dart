import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flutter/material.dart';

import 'package:update1/processing_function/my_game.dart';

import 'package:update1/MAP/tree_animation.dart';

import 'package:update1/player/handlings_player.dart';

import 'package:update1/boss_S1/animation_bullet_boss.dart';
import 'package:update1/boss_S1/animation_boss.dart';



class BossBullet extends SpriteAnimationComponent 
    with HasGameRef<MyGame>, CollisionCallbacks {

  final Vector2 direction;  // Hướng bay của đạn

  final bool isFacingRight; // Hướng quay của animation (phải/trái)

  final int attackType; // Loại đòn tấn công (1: đòn thường, 2: đòn mạnh)

  final double speed = 2000; // Tốc độ đạn 
  late int damage;  // Sát thương gây ra cho player

  late BossBulletAnimations animations;   // Quản lý animations của đạn
  bool hasHit = false;  // Cờ kiểm tra đã trúng mục tiêu chưa
  double _lifeTime = 0.0; // Thời gian tồn tại của đạn

  // Constructor chính
  BossBullet({
    required Vector2 position,  // Vị trí khởi tạo đạn
    required this.direction,  // Hướng bay
    required this.isFacingRight,  // Hướng animation
    this.attackType = 1,
  }) : 
  super(
    anchor: Anchor.center,  // Điểm neo ở trung tâm
    position: Vector2(1600, 300),  // Vị trí ban đầu
    size: Vector2(230, 230),  // Kích thước đạn
    
  )
  
   {

    //Đòn 1 20 dame, đòn 2 40 dame
     damage = attackType == 1 ? 25 : 45; 

    // Thêm hitbox hình tròn cho va chạm với bán kính 15 pixel
    add(CircleHitbox(
      radius: 16,
      anchor: Anchor.center, //PHÁT HIỆN PHẠM VI HIT BOX
      position: Vector2(110, 115),
    ));
     debugMode = true;
  }

  // Constructor mới - tạo đạn hướng về player
  BossBullet.towardsPlayer({
    required Vector2 startPosition,
    required Vector2 playerPosition,
    required this.isFacingRight,
    this.attackType = 1,
  }) : direction = (playerPosition - startPosition).normalized(),
        super(
          anchor: Anchor.center,
          position: startPosition,
          size: Vector2(200, 200),

        ) {

    //Đòn 1 25 dame, đòn 2 40 dame
    damage = attackType == 1 ? 25 : 35;

    add(CircleHitbox(
      radius: 25,
      anchor: Anchor.center,
      position: Vector2(120, 100),
    )); 
    debugMode = true;
    
  }
  
  

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Khởi tạo và tải tất cả animations
    animations = BossBulletAnimations();
    await animations.loadAllAnimations();

    // CHỌN ANIMATION THEO LOẠI ĐÒN
    if (attackType == 1) {
      animation = animations.getFlyAnimation(isFacingRight);
    } else {
      // Đòn thứ 2 dùng animation bullet2
      animation = isFacingRight ? animations.bulletFlyRight2 : animations.bulletFlyLeft2;
    }
    FlameAudio.play('snoud_effect_attack_tg.mp3');
  }
  
  @override
  void update(double dt) {
    super.update(dt);

    if (hasHit) return; // Nếu đã trúng thì không di chuyển nữa

    // Di chuyển đạn theo hướng đã định với tốc độ cố định
    position += direction.normalized() * speed * dt;

    // Cập nhật thời gian tồn tại
    _lifeTime += dt;

    // Kiểm tra nếu đạn ra khỏi màn hình hoặc tồn tại quá 5 giây thì xóa
    if (_isOutOfBounds() || _lifeTime > 5.0) {
      removeFromParent();
    }
  }
  bool _isOutOfBounds() {
    final margin = 100.0;
    return position.x < -margin || position.x > gameRef.size.x + margin ||
           position.y < -margin || position.y > gameRef.size.y + margin;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,  // Các điểm va chạm
    PositionComponent other,  // Component va chạm với đạn
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (hasHit) return; // Nếu đã trúng thì bỏ qua

    // KIỂM TRA VA CHẠM VỚI PLAYER TANK
    if (other is PlayerTank) {
      _hitPlayer(other);  // Xử lý trúng player
    }
    
    // Kiểm tra nếu đạn trúng vật cản
    if (other is TreeComponent) {
      _hitObstacle(); // Xử lý trúng vật cản
    }
  }

  // Xử lý khi trúng player - GÂY SÁT THƯƠNG
  void _hitPlayer(PlayerTank player) {
    if (hasHit) return; // Đảm bảo chỉ xử lý một lần
    
    hasHit = true;  // Đánh dấu đã trúng
    
    // GÂY SÁT THƯƠNG CHO PLAYER
    player.takeDamage(damage);
    
    // Hiệu ứng nổ
    _playHitEffect();
  }

  // Xử lý khi trúng vật cản
  void _hitObstacle() {
    if (hasHit) return;
    
    hasHit = true;
    _playHitEffect();
  }

  // Phát hiệu ứng nổ
  void _playHitEffect() {
    // CHỌN ANIMATION NỔ THEO LOẠI ĐÒN
    if (attackType == 1) {
      animation = animations.getHitEffectAnimation(isFacingRight);
    } else {
      // Đòn thứ 2 dùng effect nổ 2
      animation = isFacingRight ? animations.bulletHitEffectRight2 : animations.bulletHitEffectLeft2;
    }
    // Dừng di chuyển
    hasHit = true;
    // Loại bỏ hitbox để tránh va chạm tiếp
    for (final component in children.toList()) {
      if (component is Hitbox) {
        remove(component);
      }
    }
    // Tự động xóa sau khi animation nổ kết thúc (0.48 giây)
    add(RemoveEffect(delay: 0.48)); // 6 frames × 0.08s = 0.48s
  
  }
  // Phương thức an toàn để remove
  void safeRemove() {
    if (!hasHit) {
      _playHitEffect();
    }
  }
}


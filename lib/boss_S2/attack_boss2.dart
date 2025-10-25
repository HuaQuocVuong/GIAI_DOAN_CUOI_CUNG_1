import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:update1/boss_S2/animation_boss2.dart';

import 'package:update1/processing_function/my_game.dart';
import 'package:update1/player/handlings_player.dart';
import 'package:update1/MAP/tree_animation.dart';

class Boss2Attack extends SpriteAnimationComponent 
    with HasGameRef<MyGame>, CollisionCallbacks {
  final int damage ;  // Sát thương gây ra cho player
  final int attackType;

  static const int firstAttackDamage = 35;
  static const int secondAttackDamage = 55;

  late Boss2Animations animations;   // Quản lý animations của đòn đánh
  final bool isFacingRight; // Hướng quay của animation (phải/trái)
  
  bool hasHit = false;  // Cờ kiểm tra đã trúng mục tiêu chưa
  double _lifeTime = 0.0; // Thời gian tồn tại của đòn đánh (giây)

  Boss2Attack({
    required Vector2 position,  // Vị trí khởi tạo đòn đánh
    required this.isFacingRight,  // Hướng animation
    required this.attackType,
    required this.damage,

  }) : super(
    anchor: Anchor.center,  // Điểm neo ở trung tâm
    position: position,  // Vị trí ban đầu (tại boss)
    size: Vector2(120, 100),  // Kích thước đòn đánh
  ) {

    // Điều chỉnh vị trí dựa trên hướng
    if (isFacingRight) {
      this.position += Vector2(150, -30); // Vị trí khi tấn công bên phải
    } else {
      this.position += Vector2(-40, -30); // Vị trí khi tấn công bên trái
    }

    // Thêm hitbox cho đòn đánh
    add(RectangleHitbox(
      size: Vector2(100, 200), 
      position: Vector2(0, 150),
      anchor: Anchor.center,
    ));
  }

  // PHƯƠNG THỨC TẠO ĐÒN TẤN CÔNG THỨ NHẤT
  factory Boss2Attack.firstAttack({
    required Vector2 position,
    required bool isFacingRight,
  }) {
    return Boss2Attack(
      position: position,
      isFacingRight: isFacingRight,
      attackType: 1,
      damage: firstAttackDamage,
    );
  }

  // PHƯƠNG THỨC TẠO ĐÒN TẤN CÔNG THỨ HAI
  factory Boss2Attack.secondAttack({
    required Vector2 position,
    required bool isFacingRight,
  }) {
    return Boss2Attack(
      position: position,
      isFacingRight: isFacingRight,
      attackType: 2,
      damage: secondAttackDamage,
    );
  }


  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Âm thanh khác nhau cho mỗi loại đòn tấn công
    if (attackType == 1) {
      FlameAudio.play('swordhit1.mp3');
    } else {
      FlameAudio.play('swordhit1.mp3'); // Âm thanh khác cho đòn 2
    }
  }
  
  @override
  void update(double dt) {
    super.update(dt);

    if (hasHit) return; // Nếu đã trúng thì không xử lý nữa

    // Cập nhật thời gian tồn tại
    _lifeTime += dt;

    // Kiểm tra nếu đòn đánh tồn tại quá 0.6 giây thì xóa (vì là đánh gần)
    if (_lifeTime > 0.6) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,  // Các điểm va chạm
    PositionComponent other,  // Component va chạm với đòn đánh
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (hasHit) return; // Nếu đã trúng thì bỏ qua
    
    // KIỂM TRA VA CHẠM VỚI PLAYER TANK
    if (other is PlayerTank) {
      _hitPlayer(other);  // Xử lý trúng player
    }
    
    // Kiểm tra nếu đòn đánh trúng vật cản
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

    _playHitEffect();
  }

  // Xử lý khi trúng vật cản
  void _hitObstacle() {
    if (hasHit) return;
    
    hasHit = true;
    _playHitEffect();
  }

  // Phát hiệu ứng khi kết thúc
  void _playHitEffect() {
    // Dừng xử lý
    hasHit = true;

    // Loại bỏ hitbox để tránh va chạm tiếp
    for (final component in children.toList()) {
      if (component is Hitbox) {
        remove(component);
      }
    }
    
    // Tự động xóa sau một khoảng thời gian ngắn
    add(RemoveEffect(delay: 0.1));
  }

  // Phương thức an toàn để remove
  void safeRemove() {
    if (!hasHit) {
      _playHitEffect();
    }
  }
}
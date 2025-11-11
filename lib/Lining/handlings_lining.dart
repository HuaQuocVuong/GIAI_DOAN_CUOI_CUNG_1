import 'package:flame/collisions.dart';
import 'package:flame/components.dart';


import 'package:update1/processing_function/my_game.dart';

import 'package:update1/Lining/animation_lining.dart';

import 'package:update1/player/handlings_player.dart';

class DangerZone extends SpriteAnimationComponent 
    with HasGameRef<MyGame>, CollisionCallbacks {
  
  final double damageAmount;  // Sát thương
  final double lifeTime;  // Thời gian tồn tại (giây)
  final LightningType lightningType; // Loại sét đánh
  
  double _lifeTimer = 0;  // Bộ đếm thời gian tồn tại
  PlayerTank? _currentPlayer; // Tham chiếu đến player hiện tại trong vùng nguy hiểm

  //Trừu tượng: Cho phép tạo nhiều Loại Lining khác nhau trong tương lai
  DangerZone({
    required Vector2 position,  // Vị trí spawn
    required this.lightningType,  /// Loại sét đánh (VÌ CHỬ PROJECT QUÁ LƯỜI NÊN CHỈ CÓ 1 LOẠI)
    this.damageAmount = 20, // Mặc định gây 20 sát thương
    this.lifeTime = 3.5,  // Mặc định tồn tại 8 giây
  }) : super(
          position: position,
          size: Vector2(300, 600), //Kích thước 
          
          anchor: Anchor.center,  // Neo giữa
        );
  // ĐA HÌNH: ghi đè (override) hành vi gốc của Flame Component
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Load animation
    animation = await LightningAnimationManager.getAnimationByType(lightningType);
    
    // Thêm hitbox va chạm với người chơi
    add(RectangleHitbox(
      size: Vector2(250, 150), //hitbox
      position: Vector2(165, 518),  //Vị trí hitbox phù hợp với animation
      anchor: Anchor.center,  // Neo giữa
    )..collisionType = CollisionType.active);

    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Quản lý thời gian tồn tại
    _lifeTimer += dt; // Cộng dồn thời gian
    
     // Nếu vượt quá thời gian tồn tại, xóa DangerZone khỏi game
    if (_lifeTimer >= lifeTime) {
      removeFromParent();   // Xóa component khỏi game
    }
  }
  //  
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    
    if (other is PlayerTank) {
      _currentPlayer = other;
      _applyDamage(); // Gây sát thương ngay khi va chạm
    }
  }
  // Gây sát thương liên tục khi vẫn trong vùng nguy hiểm
  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    
    if (other is PlayerTank) {
      _currentPlayer = null;
    }
  }
  // Gây sát thương cho player trong vùng nguy hiểm
  void _applyDamage() {
    if (_currentPlayer != null && 
        _currentPlayer!.isMounted && 
        _currentPlayer!.isAlive) {
      _currentPlayer!.takeDamage(damageAmount.toInt());
    }
  }
}
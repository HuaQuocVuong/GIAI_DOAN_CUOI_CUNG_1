import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:update1/processing_function/my_game.dart';

import 'package:update1/boss_S1/animation_boss.dart';
import 'package:update1/boss_S1/animation_bullet_boss.dart';
import 'package:update1/boss_S1/health_bar_is_boss.dart';
import 'package:update1/boss_S1/bullet_boss.dart';

import 'package:update1/teleportation_stone.dart';

class Boss extends SpriteAnimationComponent with HasGameRef<MyGame> {
  // Animation controller
  late BossAnimations animations;
  
  // Boss properties - CHỈ CẦN CÁI CƠ BẢN TRƯỚC
  bool isFacingRight = false;
  bool isDead = false;

  //Health 
  double maxHealth = 1000;
  double health = 1000;

  // Biến cho việc tấn công 
  double _attackTimer = 0;
  static const double _attackInterval = 3.0;  // 2 giây bắn 1 lần
  bool _isAttacking = false;

   // BIẾN QUẢN LÝ LUÂN PHIÊN ĐÒN TẤN CÔNG
  int _currentAttackType = 1; // 1: đòn thứ nhất, 2: đòn thứ hai

  Boss({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Load animations
    animations = BossAnimations();
    await animations.loadAllAnimations();
    
    // Set initial animation - CHỈ DÙNG IDLE TRƯỚC
    animation = animations.idleLeft;
    anchor = Anchor.center;

    add(RectangleHitbox(
      size: Vector2(90, 200),  //Rộng/dài hit box
      anchor: Anchor.center,
      position: Vector2(210, 250),  //Vị trí hit box
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if (isDead) return;

    // Kiểm tra nếu player chết thì dừng mọi hoạt động
    if (_isPlayerDead()) {
      // Chuyển về animation idle và không làm gì cả
      if (!_isAttacking) {
        animation = animations.idleLeft;
      }
      return;
    }

    _attackTimer += dt;

    // Nếu đến lượt tấn công
    if (_attackTimer >= _attackInterval && !_isAttacking) {
      _attack();
      _attackTimer = 0;
    }
  }

  // Phương thức kiểm tra player có chết không
  bool _isPlayerDead() {
    
    // Kiểm tra player có tồn tại không
    //if (gameRef.player == null) return true;
    
    // Kiểm tra thông qua getter public từ PlayerTank
    return gameRef.player.isDead || gameRef.player.isDying;
  }

   // Tấn công
  void _attack() {
    if (isDead) return;
    
    _isAttacking = true;
    
    // LẤY ANIMATION TẤN CÔNG THEO LOẠI ĐÒN
    final attackAnimation = _getCurrentAttackAnimation();
    animation = attackAnimation;

    _playAttackSound();
    
     // Sử dụng timer thay vì onComplete
    Future.delayed(Duration(milliseconds: 400), () { //500
      if (!isDead && _isAttacking && !_isPlayerDead()) {
        _shootBullet();
        _isAttacking = false;
        
        // CHUYỂN SANG ĐÒN TIẾP THEO
        _switchToNextAttack();
        
        // Quay lại trạng thái idle sau 0.5 giây
        Future.delayed(Duration(milliseconds: 500), () {
          if (!isDead && !_isPlayerDead()) {
            animation = animations.idleLeft;
          } else {
            // Nếu player đã chết, giữ nguyên trạng thái idle
            animation = animations.idleLeft;
          }
        });
      } else {
        _isAttacking = false;
      }
    });
  }

  // LẤY ANIMATION TẤN CÔNG THEO LOẠI ĐÒN HIỆN TẠI
  SpriteAnimation _getCurrentAttackAnimation() {
    if (_currentAttackType == 1) {
      return isFacingRight ? animations.attackRight : animations.attackLeft;
    } else {
      return isFacingRight ? animations.attackRight2 : animations.attackLeft2;
    }
  }
  // CHUYỂN SANG ĐÒN TẤN CÔNG TIẾP THEO
  void _switchToNextAttack() {
    _currentAttackType = _currentAttackType == 1 ? 2 : 1;
  }

   // CHƠI SOUND EFFECT THEO LOẠI ĐÒN
  void _playAttackSound() {
    if (_currentAttackType == 1) {
      FlameAudio.play('tg1_attack_snoud1.mp3');
    } else {
      FlameAudio.play('tg1_attack_snoud1.mp3'); // Sound effect cho đòn thứ 2
    }
  }

  // Bắn đạn
  void _shootBullet() {
    // Kiểm tra lại nếu player còn sống
    if (_isPlayerDead()) return;

    // Kiểm tra nếu player tồn tại
    final player = gameRef.player;

    // Tính vector hướng từ boss đến player
    final Vector2 direction = (player.position - position).normalized();

    // Xác định hướng thực tế của đạn
    final bool isBulletFacingRight = direction.x > 0;
    
    // Tạo đạn với hướng về phía player
    final bullet = BossBullet(
      position: position.clone(),
      direction: direction,
      isFacingRight: isBulletFacingRight,
      attackType: _currentAttackType, // TRUYỀN LOẠI ĐÒN TẤN CÔNG
    );
    
    // Thêm đạn vào game
    gameRef.add(bullet);
  }

   // RESET CHU KỲ TẤN CÔNG
  void resetAttackCycle() {
    _currentAttackType = 1;
    _attackTimer = 0;
    _isAttacking = false;
  }

  void takeDamage(double damage) {
    if (isDead) return;
    
    health -= damage;
    if (health <= 0) {
      health = 0;
      die();
    }
  }

  void die() {
    if (isDead) return;
    
    isDead = true;
    // LUÔN DÙNG ANIMATION CHẾT TRÁI
    animation = animations.deathLeft;
    FlameAudio.play('snoud_BOSS1_Death.mp3');

    resetAttackCycle();

    // Vô hiệu hóa va chạm
    for (final component in children.toList()) {
      if (component is Hitbox) {
        remove(component); // Xóa hitbox
      }
    }

    // THÊM VIÊN ĐÁ RƠI RA SAU 4 GIÂY
    Future.delayed(Duration(seconds: 5), () {
      // THÊM VIÊN ĐÁ RƠI RA KHI BOSS CHẾT
      _spawnTeleportationStone();
    });
  }

  // HÀM TẠO VIÊN ĐÁ TELEPORT
  void _spawnTeleportationStone() {
    final stone = TeleportationStone(
      position: Vector2(1635, 320), // Vị trí rơi ngay tại boss
      size: Vector2(120, 120), // Kích thước viên đá
    );
  
  // Thêm viên đá vào game
  gameRef.add(stone);
  }
  // Getter để kiểm tra trạng thái
  int get currentAttackType => _currentAttackType;
  bool get isAlive => !isDead;
  bool get isAttacking => _isAttacking;
}
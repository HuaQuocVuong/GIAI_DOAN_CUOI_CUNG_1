import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:update1/boss_S2/attack_boss2.dart';
import 'package:update1/player/handlings_bullets_player.dart';
import 'package:update1/processing_function/my_game.dart';
import 'package:update1/boss_S2/animation_boss2.dart';
import 'package:update1/player/handlings_player.dart';
import 'package:update1/boss_S2/health_bar_is_boss2.dart';


class Boss2 extends SpriteAnimationComponent with HasGameRef<MyGame>, CollisionCallbacks  {
  late Boss2Animations animations;

  // Biến cho AI di chuyển
  bool isFacingRight = false;
  bool isDead = false;

   // THÊM BIẾN NÀY - KIỂM TRA ĐANG CHẾT
  bool _isDying = false;
  
   // Health system - THÊM VÀO
  double maxHealth = 1000; // Có thể điều chỉnh
  double health = 1000;

  // Timers
  double _moveTimer = 0;
  double _attackTimer = 0;
  double _phaseTimer = 0; // Timer để theo dõi thời gian chuyển phase
  static const double _moveInterval = 0.01;
  static const double _attackInterval = 0.8;
  
  // Tốc độ và phase
  double _currentMoveSpeed = 180; // Tốc độ hiện tại
  final double _normalSpeed = 180; // Tốc độ bình thường
  final double _fastSpeed = 360; // Tốc độ nhanh (gấp đôi)
  final double _phaseChangeTime = 1.2; // Sau x giây chuyển run
  
  bool _isAttacking = false;
  bool _isFastPhase = false; // Đã chuyển sang phase chạy nhanh chưa

  Boss2({
    required Vector2 position,
    required Vector2 size,
  }) : super(
    position: position, 
    size: Vector2(500, 500)
    );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Load animations
    animations = Boss2Animations();
    await animations.loadAllAnimations();
    
    // Set initial animation
    animation = animations.idleLeft;
    anchor = Anchor.center;

    // Thêm hitbox đơn giản
    add(RectangleHitbox(
      size: Vector2(30, 200),
      position: Vector2(235, 400),
      anchor: Anchor.center,
    ));
    //debugMode = true;

    // THÊM THANH MÁU CHO BOSS2
    final healthBar = Boss2HealthBar(boss: this);
    gameRef.add(healthBar); 
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isDead || _isDying) return;

    // Kiểm tra nếu player chết thì dừng mọi hoạt động
    if (_isPlayerDead()) {
      // Chuyển về animation idle và không làm gì cả
      if (!_isAttacking) {
        animation = isFacingRight ? animations.idleRight : animations.idleLeft; //
      }
      return;
    }
    
    _moveTimer += dt;
    _attackTimer += dt;
    _phaseTimer += dt;
    
    // KIỂM TRA CHUYỂN PHA SAU 3 GIÂY
    if (!_isFastPhase && _phaseTimer >= _phaseChangeTime) {
      _switchToFastPhase();
    }
    
    // Cập nhật hướng và di chuyển
    if (_moveTimer >= _moveInterval && !_isAttacking) {
      _followPlayer();
      _moveTimer = 0;
    }
    
    // Kiểm tra tấn công
    if (_attackTimer >= _attackInterval && !_isAttacking && !_isPlayerDead()) {
      _attackPlayer();
      _attackTimer = 0;
    }
  }

  // THÊM PHƯƠNG THỨC XỬ LÝ VA CHẠM 
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (isDead) return;

    // KIỂM TRA VA CHẠM VỚI ĐẠN CỦA PLAYER
    if (other is Bullet) {
      _handlePlayerBulletHit(other);
    }
  }

  // XỬ LÝ KHI BỊ ĐẠN PLAYER BẮN TRÚNG
  void _handlePlayerBulletHit(Bullet bullet) {
    if (isDead) return;
    
    // Nhận sát thương từ đạn player
    takeDamage(bullet.damage);
    
    // Xóa đạn player sau khi trúng
    bullet.removeFromParent();
  }

  // Phương thức kiểm tra player có chết không
  bool _isPlayerDead() {
    
    // Kiểm tra player có tồn tại và có thuộc tính isAlive không
    //if (gameRef.player == null) return true;
    
    // Giả sử PlayerTank có thuộc tính isAlive để kiểm tra còn sống không
    // Nếu không có isAlive, có thể kiểm tra health <= 0
    return gameRef.player.isDead || gameRef.player.isDying;
  }


  void _switchToFastPhase() {
     if (_isPlayerDead()) return;
    _isFastPhase = true;
    _currentMoveSpeed = _fastSpeed; // Tăng tốc độ lên gấp đôi
    
    // Cập nhật animation chạy nhanh ngay lập tức
    if (!_isAttacking) {
      animation = isFacingRight ? animations.runRight : animations.runLeft;
    }
  }

  void _followPlayer() {
    // Kiểm tra nếu player chết thì không di chuyển
    if (_isPlayerDead()) return;
    final player = gameRef.player;
    final double distanceToPlayer = (player.position - position).length;
    
    if (distanceToPlayer > 100) {
      final Vector2 direction = (player.position - position).normalized();
      position += direction * _currentMoveSpeed * _moveInterval;
      _updateFacingDirection(direction.x);
      
      // CẬP NHẬT ANIMATION THEO PHASE
      if (!_isAttacking) {
        if (_isFastPhase) {
          // Phase chạy nhanh - dùng animation run
          animation = isFacingRight ? animations.runRight : animations.runLeft;
        } else {
          // Phase bình thường - dùng animation walk
          animation = isFacingRight ? animations.walkRight : animations.walkLeft;
        }
      }
    } 
    else {
      // Khi đứng gần player
      if (!_isAttacking) {
        // Vẫn giữ animation theo phase
        if (_isFastPhase) {
          animation = isFacingRight ? animations.runRight : animations.runLeft;
        } else {
          animation = isFacingRight ? animations.walkRight : animations.walkLeft;
        }
      }
    }
  }

  void _attackPlayer() {
    // chỉ tấn công khi player còn sống
    if (_isPlayerDead()) {
      _isAttacking = false;
      return;
    }

    final player = gameRef.player;
    final double distanceToPlayer = (player.position - position).length;
    
    if (distanceToPlayer <= 150) {
      _isAttacking = true;
      _performAttackCombo(); // THỰC HIỆN COMBO 2 ĐÒN LIÊN TIẾP
    } else {
      _isAttacking = false;
    }
  }
  // THÊM PHƯƠNG THỨC THỰC HIỆN COMBO 2 ĐÒN
  void _performAttackCombo() {

      // Chuyển animation tấn công
      animation = isFacingRight ? animations.attackRight : animations.attackLeft;
      
      // Tạo đòn đánh thứ nhất với damage = 40
      final attack1 = Boss2Attack.firstAttack(
        position: position.clone(),
        isFacingRight: isFacingRight,
      );
      gameRef.add(attack1);

      // Reset trạng thái tấn công sau khi animation kết thúc
      Future.delayed(Duration(milliseconds: 750), () {
        if (isDead || _isDying || _isPlayerDead()) {
          _isAttacking = false;
          return;
        }

        // ĐÒN TẤN CÔNG THỨ HAI
        animation = isFacingRight ? animations.attackRight2 : animations.attackLeft2;
        
        // Tạo đòn đánh thứ hai với damage = 80 (gấp đôi)
        final attack2 = Boss2Attack.secondAttack(
          position: position.clone(),
          isFacingRight: isFacingRight,
        );
        gameRef.add(attack2);

        // SAU KHI COMBO HOÀN THÀNH
        Future.delayed(Duration(milliseconds: 600), () {
          _isAttacking = false;
          if (!_isPlayerDead()) {
            _resetToNormalMovement();
          } else {
            animation = isFacingRight ? animations.idleRight : animations.idleLeft;
          }
        });
      });
    }

    // THÊM PHƯƠNG THỨC RESET VỀ DI CHUYỂN BÌNH THƯỜNG
    void _resetToNormalMovement() {
      _isFastPhase = false;   // Reset về phase đi bộ
      _currentMoveSpeed = _normalSpeed;  // Reset tốc độ
      _phaseTimer = 0;                // Reset timer để đếm lại 3 giây

      // RESET VỀ ANIMATION ĐI BỘ SAU KHI TẤN CÔNG
      if (!_isPlayerDead()) {
        animation = isFacingRight ? animations.walkRight : animations.walkLeft;
      } else {
        animation = isFacingRight ? animations.idleRight : animations.idleLeft;
      }
    }


    void _updateFacingDirection(double directionX) {
      if (directionX > 0 && !isFacingRight) {
        isFacingRight = true;
      } else if (directionX < 0 && isFacingRight) {
        isFacingRight = false;
      }
    }

    // THÊM PHƯƠNG THỨC NHẬN SÁT THƯƠNG
    void takeDamage(double damage) {
      if (isDead) return;
      
      health -= damage;
      if (health <= 0) {
        health = 0;
        die();
      }
    }
    // THÊM PHƯƠNG THỨC CHẾT
    void die() {
      if (isDead || _isDying) return; // THÊM KIỂM TRA _isDying
      
      isDead = true;
      _isDying = true; // ĐÁNH DẤU ĐANG CHẾT
      _isAttacking = false;
      
      // Chuyển animation chết
      animation = isFacingRight ? animations.dieRight : animations.dieLeft;
      animation!.loop = false;
      
      // Vô hiệu hóa hitbox
      for (final component in children.toList()) {
        if (component is Hitbox) {
          remove(component);
        }
    }
    
    // Tự động xóa sau khi animation chết kết thúc
    Future.delayed(Duration(milliseconds: 2000), () {
      _isDying = false;
      if (isMounted) {
        removeFromParent();
      }
    });
  }

  // Phương thức để reset boss 
  void resetBoss() {
    _isFastPhase = false;
    _currentMoveSpeed = _normalSpeed;
    _phaseTimer = 0;
    _isAttacking = false;
    _isDying = false; // THÊM DÒNG NÀY
    health = maxHealth; // Reset máu
    animation = animations.idleLeft;
  }
  
  // Getter để kiểm tra trạng thái (nếu cần)
  bool get isInFastPhase => _isFastPhase;
  double get currentSpeed => _currentMoveSpeed;
  bool get isAlive => !isDead;
}
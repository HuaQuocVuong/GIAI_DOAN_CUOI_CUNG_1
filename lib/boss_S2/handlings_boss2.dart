import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:update1/processing_function/my_game.dart';

import 'package:update1/player/handlings_player.dart';
import 'package:update1/player/handlings_bullets_player.dart';

import 'package:update1/boss_S2/attack_boss2.dart';
import 'package:update1/boss_S2/animation_boss2.dart';
import 'package:update1/boss_S2/health_bar_is_boss2.dart';

class Boss2 extends SpriteAnimationComponent with HasGameRef<MyGame>, CollisionCallbacks  {
  
  // Trừu tượng: tách riêng phần quản lý animation
  late Boss2Animations animations;

  // Biến di chuyển
  bool isFacingRight = false;
  bool isDead = false;  // Biến trạng thái chết

  // KIỂM TRA ĐANG CHẾT
  bool _isDying = false;  // Biến theo dõi trạng thái chết
  
   // Health system
  double maxHealth = 2000; // Máu tối đa
  double health = 2000; // Máu hiện tại

  // Đóng gói = private
  double _moveTimer = 0; // Timer để theo dõi thời gian di chuyển
  double _attackTimer = 0; // Timer để theo dõi thời gian tấn công
  double _phaseTimer = 0; // Timer để theo dõi thời gian chuyển phase
  static const double _moveInterval = 0.01; // Thời gian giữa các lần di chuyển
  static const double _attackInterval = 1.0; // Thời gian giữa các lần tấn công
  
  // Tốc độ và phase
  double _currentMoveSpeed = 180; // Tốc độ hiện tại
  final double _normalSpeed = 180; // Tốc độ bình thường
  final double _fastSpeed = 400; // Tốc độ nhanh (gấp đôi)
  final double _phaseChangeTime = 1.0; // Sau x giây chuyển run
  
  bool _isAttacking = false;  // Đang tấn công hay không
  bool _isFastPhase = false; // Đã chuyển sang phase chạy nhanh chưa

  //TRỪU TƯỢNG: constructor cho phép tạo boss với vị trí và kích thước tùy ý
  Boss2({
    required Vector2 position, // Vị trí khởi tạo boss
    required Vector2 size, // Kích thước boss
  }) : super(
    position: position,  // Vị trí khởi tạo boss
    size: Vector2(500, 500) // Kích thước boss
    );

  //ĐA HÌNH: ghi đè (override) hành vi tải mặc định của component
  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Load animations
    animations = Boss2Animations(); // Khởi tạo quản lý animations
    await animations.loadAllAnimations(); // Tải tất cả animations
    
    // Set initial animation
    animation = animations.idleLeft;
    anchor = Anchor.center;

    // Thêm hitbox cho boss (Trừu tượng vì sử dụng lớp CollisionCallBaks )
    add(RectangleHitbox(
      size: Vector2(30, 200), // Hitbox cho boss
      position: Vector2(235, 400), // Vị trí hitbox
      anchor: Anchor.center, // Neo giữa
    ));

    // THÊM THANH MÁU CHO BOSS2
    final healthBar = Boss2HealthBar(boss: this);
    gameRef.add(healthBar); 
  }


  // Đa hình : ghi đè (override) hành vi cập nhật mặc định của component
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
    //bullet.removeFromParent();
     bullet.safeRemove();
  }

  // Phương thức kiểm tra player có chết không
  bool _isPlayerDead() {
    
    // Kiểm tra player có tồn tại và có thuộc tính isAlive không
    //if (gameRef.player == null) return true;
    
    // Giả sử PlayerTank có thuộc tính isAlive để kiểm tra còn sống không
    // Nếu không có isAlive, có thể kiểm tra health <= 0
    return gameRef.player.isDead || gameRef.player.isDying;
  }

  // THÊM PHƯƠNG THỨC CHUYỂN SANG PHA CHẠY NHANH
  void _switchToFastPhase() {
     if (_isPlayerDead()) return;
    _isFastPhase = true;
    _currentMoveSpeed = _fastSpeed; // Tăng tốc độ lên gấp đôi
    
    // Cập nhật animation chạy nhanh ngay lập tức
    if (!_isAttacking) {
      animation = isFacingRight ? animations.runRight : animations.runLeft;
    }
  }
  //TRỪU TƯỢNG + ĐÓNG GÓI: hành vi di chuyển ẩn bên trong, bên ngoài chỉ cần gọi
  void _followPlayer() {
    // Kiểm tra nếu player chết thì không di chuyển
    if (_isPlayerDead()) return;
    final player = gameRef.player;  // Lấy tham chiếu đến player
    final double distanceToPlayer = (player.position - position).length; // Khoảng cách đến player
    // Di chuyển về phía player nếu khoảng cách lớn hơn ngưỡng
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
  // TRỪU TƯỢNG + ĐÓNG GÓI: hành vi tấn công ẩn bên trong, bên ngoài chỉ cần gọi
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
  // THÊM PHƯƠNG THỨC THỰC HIỆN COMBO 2 ĐÒN  (Đa Hình)
  void _performAttackCombo() {

      // Chuyển animation tấn công
      animation = isFacingRight ? animations.attackRight : animations.attackLeft;
      
      // Tạo đòn đánh thứ nhất 
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
        
        // Tạo đòn đánh thứ hai 
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

    //
    void _updateFacingDirection(double directionX) {
      if (directionX > 0 && !isFacingRight) {
        isFacingRight = true;
      } else if (directionX < 0 && isFacingRight) {
        isFacingRight = false;
      }
    }

    //ĐÓNG GÓI: boss tự xử lý sát thương nhận vào
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
    _isFastPhase = false; // Reset phase
    _currentMoveSpeed = _normalSpeed; // Reset tốc độ
    _phaseTimer = 0;   // Reset timer
    _isAttacking = false; // Reset trạng thái tấn công
    _isDying = false; // Reset trạng thái chết
    health = maxHealth; // Reset máu
    animation = animations.idleLeft;
  }
  
  // ĐÓNG GÓI: dùng getter để truy cập thay vì biến trực tiếp
  // Getter để kiểm tra trạng thái (nếu cần)
  bool get isInFastPhase => _isFastPhase;
  double get currentSpeed => _currentMoveSpeed;
  bool get isAlive => !isDead;
}
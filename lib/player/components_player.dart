import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/collisions.dart'; 

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:update1/processing_function/my_game.dart';
import 'package:update1/player/click_marker.dart';

import 'package:update1/player/health_bar_player.dart';
import 'package:update1/processing_function/player_respawn_manager.dart'; 
import 'package:update1/player/animation_player.dart';

// Định hướng của nhân vật: left, right
enum TankDirection { left, right }

class PlayerTank extends PositionComponent with HasGameRef<MyGame>, CollisionCallbacks {
  
  // THÔNG SỐ NHÂN VẬT
  int currentHealth = 200;   // Máu hiện tại
  int maxHealth = 200;  // Máu tối đa
  late HealthBar healthBar ;  // Thanh máu hiển thị
  late PlayerRespawnManager respawnManager; // Quản lý hồi sinh
  late PlayerAnimations animations; // Tất cả animation của player
  
  // THÀNH PHẦN HIỂN THỊ NHÂN VẬT
  late SpriteAnimationComponent tank;
  
  // DI CHUYỂN VÀ MỤC TIÊU
  late Vector2 targetPosition;  // Vị trí mục tiêu di chuyển đến
  final double baseSpeed = 30; // Tốc độ di chuyển cơ bản 
  final double runSpeed = 80; // Tốc độ chạy  80
  double get currentSpeed => _isRunning ? runSpeed : baseSpeed;
  
  bool _isMoving = false;  // Kiểm tra đang di chuyển hay không
  bool _isAttacking = false;  // Kiểm tra đang tấn công hay không
  int _comboCount = 0;  // Đếm số combo tấn công (0 hoặc 1)
  bool _isTransitioning = false;  // Đang chuyển đổi animation hay không

  String _currentDirection = 'right';  // Hướng hiện tại: 'left' hoặc 'right'

  // Hệ thống idle (animation khi đứng yên lâu)
  double _idleTime = 0.0;  // Thời gian đã đứng yên
  bool _isPlayingIdleSpecial = false;  // Kiểm đang chơi animation idle đặc biệt không
  static const double _idleSpecialThreshold = 1.5; // Sau 5s đứng yên -> phát animation idle đặc biệt
  
  // Hệ thống run (animation khi di chuyển liên tục)
  double _moveTime = 0.0;  // Thời gian đã di chuyển liên tục
  bool _isRunning = false;  // Đang ở trạng thái chạy
  static const double _runThreshold = 0.65; // Sau x(s) di chuyển -> kích hoạt run

  bool _isDead = false;  // Đã die hoàn toàn
  bool _isDying = false; // Đang trong animation die

  // Di chuyển bằng bàn phím
  Vector2 _keyboardDirection = Vector2.zero();
  final double _baseKeyboardMoveSpeed = 350;
  final double _runKeyboardMoveSpeed = 500; // Tăng 150 so với base
  double get _currentKeyboardMoveSpeed => _isRunning ? _runKeyboardMoveSpeed : _baseKeyboardMoveSpeed;

  // Khởi tạo người chơi
  PlayerTank()
      : super(
          anchor: Anchor.center,  // Điểm neo ở trung tâm
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Khởi tạo thanh máu
    healthBar = HealthBar(tank: this);
    await healthBar.loadHealthSprites();
    add(healthBar);

    // Khởi tạo hệ thống quản lý hồi sinh 
    respawnManager = PlayerRespawnManager(player: this);
    add(respawnManager);

    // load tất cả animation 
    animations = PlayerAnimations();
    await animations.loadAllAnimations();

    tank = SpriteAnimationComponent(
      animation: animations.idle, // Animation mặc định khi đứng yên
      size: Vector2.all(150), // Kích thước hiển thị
      anchor: Anchor.center,  // Neo ở trung tâm
      position: Vector2.zero(), // Vị trí trong component
    );
    add(tank);

    // Đặt nhân vật ở giữa màn hình khi bắt đầu
    position = Vector2(100, 280);
    targetPosition = position.clone();

    // Thêm hitbox để va chạm
    add(RectangleHitbox(
      size: Vector2(30, 80),  // Chiều dài/ rộng hit box 
      anchor: Anchor.center,
      position: Vector2(-5, 30),  // Vị trí hit box
    )..collisionType = CollisionType.active);
  }

  // PHƯƠNG THỨC DI CHUYỂN BẰNG BÀN PHÍM
  void moveWithKeys(Vector2 direction) {
    if (!respawnManager.canPlayerAct) return;
    
    _keyboardDirection = direction;
    targetPosition = position.clone();
    
    // Cập nhật hướng nhân vật dựa trên hướng di chuyển
    if (direction.x > 0) {
      _currentDirection = 'right';
    } else if (direction.x < 0) {
      _currentDirection = 'left';
    }
    // Nếu chỉ di chuyển lên/xuống, giữ nguyên hướng hiện tại
  }

  // Xử lý nhân vật khi chết
  void _handleDeath() {
    // Nếu đã chết hoặc đang chết thì không xử lý lại
    if (_isDead || _isDying || !isMounted) {
      return;
    }

    _isDead = true;
    _isDying = true;

    // Dừng mọi hành động khi chết
    _isMoving = false;
    _isAttacking = false;
    _isTransitioning = false;
    _isPlayingIdleSpecial = false;
    _isRunning = false; // Reset trạng thái chạy
    _moveTime = 0.0; // Reset thời gian di chuyển
    _comboCount = 0;
    _resetIdleTimer();

    // Âm thanh khi chết
    FlameAudio.play('PlayerDie2.mp3');

    _changeAnimation(animations.death, loop: false);
    FlameAudio.play('snoud_effec_death_1.mp3');
    
    // Tính thời gian chạy animation chết
    final deathAnimationDuration = _calculateDeathAnimationDuration();

    // Sau khi animation chết kết thúc -> Tạm thời gỡ vật khỏi màn hình
    Future.delayed(Duration(milliseconds: deathAnimationDuration), () {
      if (isMounted && _isDying) {
         _isDying = false;
        _isDead = true;

        removeFromParent(); // Xóa khỏi game 

        // Sau 2 giây -> gọi nhân vậ trở lại game
        Future.delayed(const Duration(seconds: 2), () {
          if (!respawnManager.isRespawning) {
           respawnManager.startRespawn();
          }
        });
      }
    });
  } 

  // Tính tổng thời gian animation chết
  int _calculateDeathAnimationDuration() {
    try {
      if (animations.death.frames.isEmpty) return 3000;
      
      double totalDuration = 0;
      for (final frame in animations.death.frames) {
        totalDuration += frame.stepTime;
      }
      return (totalDuration * 1000).round();
    } catch (e) {
      return 3000;
    }
  }

  // Chuyển đổi animation 
  void _changeAnimation(SpriteAnimation newAnimation, {bool loop = true}) {
    if (tank.animation == newAnimation) return; // Không đổi nếu animation khai báo giống nhau
    tank.animation = newAnimation;
    if (!loop) {
      tank.animation!.loop = false; // Tắt lặp lại nếu không cần
    }
  }

  // Chuyển tiếp animation (sau khi tấn công)
  void _startTransition(TankDirection direction) {
    _isTransitioning = true;
    
    // Chọn animation chuyển động theo hướng
    if (direction == TankDirection.right) {
      _changeAnimation(animations.transitionRight, loop: false);
      _currentDirection = 'right';
    } else {
      _changeAnimation(animations.transitionLeft, loop: false);
      _currentDirection = 'left';
    }

    // Sau 0.15s -> quay về trạng thái idle
    final transitionDuration = 0.15;
    Future.delayed(Duration(milliseconds: (transitionDuration * 1000).round()), () {
      if (isMounted && respawnManager.canPlayerAct && _isTransitioning) {
        _isTransitioning = false;
        _changeAnimation(animations.idle);  // Quay trở về trạng thái đứng yên
      } 
    });
  }

  // Phương tấn công
  void attack(Vector2 direction) {
    if (!respawnManager.canPlayerAct || _isAttacking) return;

    _resetIdleTimer(); // reset về animation đứng yên
    _resetMoveTimer(); // reset thời gian di chuyển (dừng chạy)
    _isAttacking = true;

    // Xác định hướng và loại combo
    if (direction.x > 0) {
      if (_comboCount == 0) {
        _changeAnimation(animations.attackRight, loop: false);
        FlameAudio.play('skill2.mp3');
        FlameAudio.play('swordhit1.mp3');
      } else {
        _changeAnimation(animations.attackRightCombo, loop: false);
        FlameAudio.play('skill1.mp3');
        FlameAudio.play('swordhit1.mp3');
      }
      _currentDirection = 'right';
    } else {
      if (_comboCount == 0) {
        _changeAnimation(animations.attackLeft, loop: false);
        FlameAudio.play('skill2.mp3');
        FlameAudio.play('swordhit1.mp3');
      } else {
        _changeAnimation(animations.attackLeftCombo, loop: false);
        FlameAudio.play('skill1.mp3');
        FlameAudio.play('swordhit1.mp3');
      }
      _currentDirection = 'left';
    }

    // TĂNG COMBO COUNT VÀ RESET VỀ 0 SAU KHI ĐẠT 2
    _comboCount = (_comboCount + 1) % 2;

    // THỜI GIAN TẤN CÔNG: 0.3 GIÂY
    final attackDuration = 0.3;
    Future.delayed(Duration(milliseconds: (attackDuration * 1000).round()), () {
      if (isMounted && respawnManager.canPlayerAct) {
        _isAttacking = false;
        
        // NẾU COMBO COUNT = 0, CHUYỂN TIẾP VỀ IDLE
        if (_comboCount == 0) {
          if (_currentDirection == 'right') {
            _startTransition(TankDirection.right);
          } else {
            _startTransition(TankDirection.left);
          }
        } else {
          // NẾU COMBO COUNT = 1, CHUYỂN THẲNG VỀ IDLE ĐỂ CHỜ COMBO TIẾP
          _changeAnimation(animations.idle);
        }
      }
    });
  }

  @override
  void update(double dt) {
    super.update(dt);

    // DỪNG CẬP NHẬT HOÀN TOÀN KHI ĐÃ CHẾT HOẶC ĐANG CHẾT
    if (_isDead || _isDying) return;

    _updateIdleSpecial(dt); // CẬP NHẬT IDLE SPECIAL
    _updateRunState(dt); // CẬP NHẬT TRẠNG THÁI CHẠY
    
    // XỬ LÝ DI CHUYỂN BẰNG BÀN PHÍM (ƯU TIÊN CAO HƠN DI CHUYỂN TAP)
    if (respawnManager.canPlayerAct && !_isAttacking && !_isTransitioning && !_isPlayingIdleSpecial) {
      _handleKeyboardMovement(dt);
    }

    // XỬ LÝ DI CHUYỂN TAP (CHỈ KHI KHÔNG DI CHUYỂN BẰNG BÀN PHÍM)
    if (respawnManager.canPlayerAct && 
        !_isAttacking && 
        !_isTransitioning && 
        !_isPlayingIdleSpecial &&
        _keyboardDirection == Vector2.zero()) {
      
      _handleTapMovement(dt);
    }
  }

  // CẬP NHẬT TRẠNG THÁI CHẠY
  void _updateRunState(double dt) {
    if (_isMoving && !_isAttacking && !_isTransitioning && !_isPlayingIdleSpecial) {
      _moveTime += dt;
      
      // KIỂM TRA NẾU ĐẠT NGƯỠNG KÍCH HOẠT CHẠY
      if (_moveTime >= _runThreshold && !_isRunning) {
        _activateRun();
      }
    } else {
      // NẾU DỪNG DI CHUYỂN HOẶC CÓ HÀNH ĐỘNG KHÁC -> RESET CHẠY
      if (_isRunning) {
        _deactivateRun();
      }
      _resetMoveTimer();
    }
  }

  // KÍCH HOẠT TRẠNG THÁI CHẠY
  void _activateRun() {
    _isRunning = true;
    
    // CHUYỂN ANIMATION CHẠY THEO HƯỚNG
    if (_currentDirection == 'right') {
      _changeAnimation(animations.runRight);
    } else {
      _changeAnimation(animations.runLeft);
    }
    // ÂM THANH CHẠY 
    FlameAudio.play('snoud_run_player.mp3');
  }

  // TẮT TRẠNG THÁI CHẠY
  void _deactivateRun() {
    _isRunning = false;
    
    // CHUYỂN VỀ ANIMATION ĐI BỘ HOẶC IDLE
    if (_isMoving) {
      if (_currentDirection == 'right') {
        _changeAnimation(animations.walkRight);
      } else {
        _changeAnimation(animations.walkLeft);
      }
    } else {
      _changeAnimation(animations.idle);
    }
  }

  // RESET BỘ ĐẾM THỜI GIAN DI CHUYỂN
  void _resetMoveTimer() {
    _moveTime = 0.0;
  }

  // XỬ LÝ DI CHUYỂN BẰNG BÀN PHÍM
  void _handleKeyboardMovement(double dt) {
    if (_keyboardDirection != Vector2.zero()) {
      // ĐANG DI CHUYỂN BẰNG BÀN PHÍM - RESET THỜI GIAN ĐỨNG YÊN
      _resetIdleTimer();

      // DI CHUYỂN THEO HƯỚNG BÀN PHÍM
      position += _keyboardDirection * _currentKeyboardMoveSpeed * dt;
      
      // GIỚI HẠN TRONG MÀN HÌNH
      position.x = position.x.clamp(0, gameRef.size.x - tank.size.x);
      position.y = position.y.clamp(0, gameRef.size.y - tank.size.y);
      
      // CHỌN ANIMATION DI CHUYỂN THEO HƯỚNG
      if (_isRunning) {
        // ĐANG CHẠY - DÙNG ANIMATION CHẠY
        if (_keyboardDirection.x > 0) {
          _changeAnimation(animations.runRight);
          _currentDirection = 'right';
        } else if (_keyboardDirection.x < 0) {
          _changeAnimation(animations.runLeft);
          _currentDirection = 'left';
        } else {
          // NẾU CHỈ DI CHUYỂN LÊN/XUỐNG, GIỮ NGUYÊN HƯỚNG VÀ ANIMATION
          if (_currentDirection == 'right') {
            _changeAnimation(animations.runRight);
          } else {
            _changeAnimation(animations.runLeft);
          }
        }
      } else {
        // ĐANG ĐI BỘ - DÙNG ANIMATION ĐI BỘ
        if (_keyboardDirection.x > 0) {
          _changeAnimation(animations.walkRight);
          _currentDirection = 'right';
        } else if (_keyboardDirection.x < 0) {
          _changeAnimation(animations.walkLeft);
          _currentDirection = 'left';
        } else {
          // NẾU CHỈ DI CHUYỂN LÊN/XUỐNG, GIỮ NGUYÊN HƯỚNG VÀ ANIMATION
          if (_currentDirection == 'right') {
            _changeAnimation(animations.walkRight);
          } else {
            _changeAnimation(animations.walkLeft);
          }
        }
      }
      _isMoving = true;
    } else if (_isMoving) {
      // DỪNG DI CHUYỂN KHI KHÔNG CÓ PHÍM NÀO ĐƯỢC NHẤN
      _changeAnimation(animations.idle);
      _isMoving = false;
    }
  }

  // XỬ LÝ DI CHUYỂN BẰNG TAP
  void _handleTapMovement(double dt) {
    final direction = targetPosition - position;
    final currentDistance = direction.length;
    
    if (currentDistance > 1.0) {
      // ĐANG DI CHUYỂN - RESET THỜI GIAN ĐỨNG YÊN
      _resetIdleTimer();

      // TÍNH TOÁN KHOẢNG CÁCH DI CHUYỂN TRONG KHUNG HÌNH NÀY
      final moveDistance = min(currentSpeed * dt, currentDistance);
      position += direction.normalized() * moveDistance;
      
      // CHỌN ANIMATION DI CHUYỂN THEO HƯỚNG
      if (_isRunning) {
        // ĐANG CHẠY - DÙNG ANIMATION CHẠY
        if (direction.x > 0) {
          _changeAnimation(animations.runRight);
          _currentDirection = 'right';
        } else {
          _changeAnimation(animations.runLeft);
          _currentDirection = 'left';
        }
      } else {
        // ĐANG ĐI BỘ - DÙNG ANIMATION ĐI BỘ
        if (direction.x > 0) {
          _changeAnimation(animations.walkRight);
          _currentDirection = 'right';
        } else {
          _changeAnimation(animations.walkLeft);
          _currentDirection = 'left';
        }
      }
      _isMoving = true;
      
    } else if (_isMoving) {
      // ĐÃ ĐẾN MỤC TIÊU - DỪNG DI CHUYỂN
      position = targetPosition.clone();
      _changeAnimation(animations.idle);
      _isMoving = false;
    }
  }

  // CẬP NHẬT THỜI GIAN ĐỨNG YÊN CHO IDLE SPECIAL
  void _updateIdleSpecial(double dt) {
    if (!_isMoving && 
        !_isAttacking && 
        !_isTransitioning && 
        !_isPlayingIdleSpecial &&
        respawnManager.canPlayerAct) {
      
      _idleTime += dt;  // TĂNG THỜI GIAN ĐỨNG YÊN
      
      // KIỂM TRA NẾU ĐẠT NGƯỠNG KÍCH HOẠT IDLE SPECIAL
      if (_idleTime >= _idleSpecialThreshold) {
        _playIdleSpecialAnimation();
      }
    }
  }

  // PHÁT ANIMATION IDLE SPECIAL
  void _playIdleSpecialAnimation() {
    _isPlayingIdleSpecial = true;
    //FlameAudio.play('Iframe_Gracefully.mp3'); //Audio chill idle
    
    // CHỌN ANIMATION THEO HƯỚNG HIỆN TẠI
    if (_currentDirection == 'right') {
      _changeAnimation(animations.idleSpecial, loop: false);
    } else {
      _changeAnimation(animations.idleSpecial, loop: false);
    }

     // THỜI GIAN ANIMATION IDLE SPECIAL: 1.35 GIÂY
    final specialAnimationDuration = 1.5; // 1.35 giây
    
    Future.delayed(Duration(milliseconds: (specialAnimationDuration * 1000).round()), () {
      if (isMounted && respawnManager.canPlayerAct) {
        _isPlayingIdleSpecial = false;
        _resetIdleTimer();
        _changeAnimation(animations.idle);  // QUAY VỀ IDLE BÌNH THƯỜNG
      }
    });
  }

  // RESET BỘ ĐẾM THỜI GIAN ĐỨNG YÊN
  void _resetIdleTimer() {
    _idleTime = 0.0;
    _isPlayingIdleSpecial = false;
  }
  
  // NHẬN SÁT THƯƠNG
  void takeDamage(int damageAmount) {
    if (!respawnManager.canPlayerAct || _isDead || _isDying) return;
    
    currentHealth -= damageAmount;

    if (currentHealth <= 0) {
      currentHealth = 0;
      _handleDeath(); // XỬ LÝ KHI MÁU VỀ 0
    }
  }

  // HỒI MÁU
  void heal(int amount) {
    if (!respawnManager.canPlayerAct) return;

    currentHealth += amount;
    if (currentHealth > maxHealth) {
      currentHealth = maxHealth;  // KHÔNG VƯỢT QUÁ MÁU TỐI ĐA
    }
  }

  // DI CHUYỂN ĐẾN VỊ TRÍ MỚI
  void moveTo(Vector2 newTarget) {
    if (!respawnManager.canPlayerAct) return;
    _resetIdleTimer(); // 🎬 RESET TIMER KHI DI CHUYỂN
    targetPosition = newTarget.clone();
  }

  // XOAY SÚNG (CHƯA SỬ DỤNG)
  void rotateCannon(Vector2 direction) {
    if (!respawnManager.canPlayerAct) return;
    // Không xoay nhân vật
  }

  // GETTERS ĐỂ TRUY CẬP TRẠNG THÁI TỪ BÊN NGOÀI
  bool get isAlive => respawnManager.canPlayerAct && !_isDead;  // Còn sống không
  bool get isDead => _isDead; // Đã chết không
  bool get isRespawning => respawnManager.isRespawning;  // Đang hồi sinh không
  double get respawnProgress => respawnManager.respawnProgress; // Tiến trình hồi sinh
  bool get isAttacking => _isAttacking;  // Đang tấn công không
  bool get isDying => _isDying;  // Đang trong animation chết không
  bool get isRunning => _isRunning; // Đang ở trạng thái chạy

  // THÊM METHOD NÀY Ở ĐÂY - SAU GETTERS, TRƯỚC DẤU } CUỐI CÙNG
  void resetDeathState() {
    _isDead = false;
    _isDying = false;
    _isRunning = false; // Reset trạng thái chạy
    _moveTime = 0.0; // Reset thời gian di chuyển
    currentHealth = maxHealth;
    
    // ĐẢM BẢO CHUYỂN VỀ ANIMATION IDLE KHI HỒI SINH
    if (isMounted && tank.isMounted) {
      _changeAnimation(animations.idle);
    }
  }
}
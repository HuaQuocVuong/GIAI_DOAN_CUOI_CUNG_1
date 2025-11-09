import 'package:flame/components.dart';

class RainingAnimation {
  late SpriteAnimation raining; // Khai báo animation cho hiệu ứng mưa
  bool _isLoaded = false; // Kiểm tra đã tải xong animation chưa

  RainingAnimation(); // Constructor
  

  // Phương thức tải tất cả animations
  Future<void> loadAllAnimations() async {
    raining = await _createRainingAnimation();
    _isLoaded = true;
  }

  Future<SpriteAnimation> _createRainingAnimation() async {
    final sprites = <Sprite>[]; // Danh sách chứa các sprite

    // Tải và thêm sprite 
    final sprite1 = await Sprite.load('raining1.png');
    sprites.add(sprite1);
    final sprite2 = await Sprite.load('raining2.png');
    sprites.add(sprite2);

    // Tạo SpriteAnimation từ danh sách sprite
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.15, // Thời gian chuyển đổi giữa các frame (0.15 giây)
      loop: true, // Lặp lại animation vô hạn
    );
  }
  // PHƯƠNG THỨC MỚI: Trả về component với priority cao
  SpriteAnimationComponent? createRainComponent(Vector2 size) {
    if (!_isLoaded) return null;
    
    return SpriteAnimationComponent(
      animation: raining,
      size: size,
      position: Vector2.zero(),
      anchor: Anchor.topLeft,
    )..priority = 100000; // Luôn có priority cao
  }

  // Phương thức lấy animation theo tên
  SpriteAnimation? getAnimationByName(String name) {
    if (!_isLoaded) return null;
    
    switch(name) {
      case 'raining':
        return raining; // Trả về animation mưa
      default:
        return null;  // Trả về null nếu không tìm thấy tên
    }
  }
  // Getter kiểm tra trạng thái tải
  bool get isLoaded => _isLoaded;
}
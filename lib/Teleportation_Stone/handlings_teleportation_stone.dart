import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:update1/MAP/map_manager.dart';
import 'package:update1/Teleportation_Stone/teleportation_stone_animation.dart';
import  'package:update1/player/handlings_player.dart';
import 'package:update1/processing_function/my_game.dart';

class TeleportationStone extends PositionComponent with CollisionCallbacks {
  late final TeleportationStoneAnimation _animation;
  late final SpriteAnimationComponent _animationComponent;
  final MyGame game;

  TeleportationStone({
    required this.game,
      Vector2? position, 
      Vector2? size
  }) {
    
    this.position = position ?? Vector2(1700, 300);
    this.size = size ?? Vector2(128, 128); // Kích thước 
  }

  //Đa hình 
  @override
  Future<void> onLoad() async {
    await _loadAnimation(); // Tải animation
    await _setupAnimationComponent(); // Thiết lập component animation
    add(_animationComponent); // Thêm animation vào component
    
    // Đa hình: Flame tự gọi khi có va chạm -> lớp CollisionCallBacks
    // Thêm hitbox cho va chạm
    add(RectangleHitbox(
      size: Vector2(30, 60),  // Hitbox nhỏ hơn visual
      position: Vector2(45, 20),  //Vị trí để căn giữa hit box
      collisionType: CollisionType.passive,
    ));
  }

  // Tải tất cả animation cần thiết
  Future<void> _loadAnimation() async {
    _animation = TeleportationStoneAnimation();
    await _animation.loadAllAnimations();
  }

  Future<void> _setupAnimationComponent() async {
    _animationComponent = SpriteAnimationComponent(
      animation: _animation.teleportationStoneAnimation,
      size: size,
    );
  }
  
  // Xử lý khi bắt đầu va chạm
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    
    // Kiểm tra nếu player chạm vào đá
    if (other is PlayerTank) {
      _handleTeleportation(); // Kích hoạt dịch chuyển
    }
  }

  // Trừu tượng: Chỉ cần gọi changeMap không cần biết nó hoạt động như nào.
  // Xử lý logic dịch chuyển giữa các map
  void _handleTeleportation() async {
    
    // Chuyển map từ forest sang poisonousforest
    if (game.mapManager.currentMap == GameMapType.forest) {
      await game.changeMap(GameMapType.poisonousforest);
    } 
    // Hoặc chuyển ngược lại nếu muốn 
    //else if (game.mapManager.currentMap == GameMapType.poisonousforest) {
    //  await game.changeMap(GameMapType.forest);
    //}
    
    // Xoá đá dịch chuyển sau khi sử dụng (tuỳ chọn)
    removeFromParent();
  }
}

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
    this.size = size ?? Vector2(128, 128);
  }

  @override
  Future<void> onLoad() async {
    await _loadAnimation();
    await _setupAnimationComponent();
    add(_animationComponent);
    
     // Thêm hitbox cho va chạm
    add(RectangleHitbox(
      size: Vector2(30, 60),
      position: Vector2(45, 20),
      collisionType: CollisionType.passive,
    ));
  }

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
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    
    // Kiểm tra nếu player chạm vào đá
    if (other is PlayerTank) {
      _handleTeleportation();
    }
  }
  void _handleTeleportation() async {
    
    // Chuyển map từ forest sang poisonousforest
    if (game.mapManager.currentMap == GameMapType.forest) {
      await game.changeMap(GameMapType.poisonousforest);
    } 
    // Hoặc chuyển ngược lại nếu muốn
    else if (game.mapManager.currentMap == GameMapType.poisonousforest) {
      await game.changeMap(GameMapType.forest);
    }
    
    // Xoá đá dịch chuyển sau khi sử dụng (tuỳ chọn)
    removeFromParent();
  }
}

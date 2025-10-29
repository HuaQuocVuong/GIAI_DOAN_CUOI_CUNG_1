import 'package:flame/components.dart';
import 'package:update1/teleportation_stone_animation.dart';

class TeleportationStone extends PositionComponent {
  late final TeleportationStoneAnimation _animation;
  late final SpriteAnimationComponent _animationComponent;

  TeleportationStone({Vector2? position, Vector2? size}) {
    this.position = position ?? Vector2(1700, 300);
    this.size = size ?? Vector2(128, 128);
  }

  @override
  Future<void> onLoad() async {
    await _loadAnimation();
    await _setupAnimationComponent();
    add(_animationComponent);
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
}

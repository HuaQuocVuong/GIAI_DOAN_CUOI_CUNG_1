import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:update1/MAP/status_maps/raining_effect.dart';

enum MapType {
  forest,
  poisonousforest,
}

enum TimeOfDay {
  day,
  night,
  rain,
}

class BackgroundComponent extends SpriteComponent with HasGameRef {
  Timer? _cycleTimer;
  MapType _currentMap = MapType.forest;
  TimeOfDay _currentTime = TimeOfDay.day;
  
  SpriteAnimationComponent? _rainAnimation;
  RainingAnimation? _rainAnimationController;
  
  BackgroundComponent({MapType initialMap = MapType.forest})
      : _currentMap = initialMap,
        super(priority: -100);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // LOAD BACKGROUND ĐẦU TIÊN NGAY KHI KHỞI TẠO
    
    
    await _loadInitialBackground();
    FlameAudio.play('Carol_of_the_Bells.mp3');
    _resizeToFullScreen();

    // Khởi tạo animation mưa
    _rainAnimationController = RainingAnimation();

    await _rainAnimationController!.loadAllAnimations();

    _initializeTimer();
  }

  // HÀM MỚI: Load background ngay khi khởi tạo
  Future<void> _loadInitialBackground() async {
    String backgroundPath = _getBackgroundPath();
    sprite = await Sprite.load(backgroundPath);
    size = sprite!.originalSize;
    anchor = Anchor.topLeft;
    position = Vector2.zero();
  }

  // HÀM CHUYỂN MAP
  Future<void> changeMap(MapType newMap) async {
    _currentMap = newMap;

    //Nếu là map2 thì set thời gian thành rain, map1 thì day
    if (newMap == MapType.poisonousforest) {
      _currentTime = TimeOfDay.rain; // Map2 luôn là mưa
    } else {
      _currentTime = TimeOfDay.day; // Map1 bắt đầu bằng ngày
    }
    
    await _loadBackground();
    _removeRainAnimation();
  }

  void _initializeTimer() {
    _cycleTimer = Timer(10, repeat: true, onTick: _cycleTimeOfDay);
    _cycleTimer!.start();
  }

  void _cycleTimeOfDay() async {
    // MAP2 KHÔNG ĐỔI THỜI GIAN, CHỈ MAP1 ĐỔI
    if (_currentMap == MapType.forest) {
      final timeValues = TimeOfDay.values;
      final currentIndex = timeValues.indexOf(_currentTime);
      _currentTime = timeValues[(currentIndex + 1) % timeValues.length];
      await _loadBackground();
    }
  }

  // HÀM LOAD BACKGROUND VỚI HIỆU ỨNG FADE
  Future<void> _loadBackground() async {
    String backgroundPath = _getBackgroundPath();
    
    final newSprite = await Sprite.load(backgroundPath);
    
    final fadeOut = OpacityEffect.to(
      0.0,
      LinearEffectController(0.5),
      onComplete: () {
        sprite = newSprite;
        _resizeToFullScreen();
        _addWeatherEffects();
        
        final fadeIn = OpacityEffect.to(
          1.0,
          LinearEffectController(0.5),
        );
        add(fadeIn);
      },
    );
    
    add(fadeOut);
  }

  // HÀM LẤY ĐƯỜNG DẪN BACKGROUND - THÊM FALLBACK
  String _getBackgroundPath() {
    if (_currentMap == MapType.forest) {
        switch (_currentTime) {
          case TimeOfDay.day: return 'MAP.png';
          case TimeOfDay.night: return 'MAP_NIGHT.png';
          case TimeOfDay.rain: return 'MAP_RAINING.png';
        }
    }
    else if (_currentMap == MapType.poisonousforest) {
        return 'bgrMAP2.png'; // TẠM DÙNG MAP_RAINING.PNG
    }
    return 'MAP.png'; // FALLBACK
  }

  void _addWeatherEffects() {
    _removeRainAnimation();

    // Map2 luôn có mưa, Map1 chỉ có mưa khi thời gian là rain
    if (_currentTime == TimeOfDay.rain || _currentMap == MapType.poisonousforest) {
      _addRainEffect();
    }
  }

  void _addRainEffect() {
    _removeRainAnimation();
  
    final rainAnim = _rainAnimationController!.getAnimationByName('raining');
    if (rainAnim != null) {
      _rainAnimation = SpriteAnimationComponent(
        animation: rainAnim,
        size: gameRef.size,
        position: Vector2.zero(),
        anchor: Anchor.topLeft,
      )..priority = 100;
      
      add(_rainAnimation!);
    }
  }

  void _removeRainAnimation() {
    if (_rainAnimation != null) {
      _rainAnimation!.removeFromParent();
      _rainAnimation = null;
    }
  }

  void _resizeToFullScreen() {
    if (sprite != null) {
      final scaleX = gameRef.size.x / sprite!.originalSize.x;
      final scaleY = gameRef.size.y / sprite!.originalSize.y;
      final scale = scaleX > scaleY ? scaleX : scaleY; 
      size = sprite!.originalSize * scale;
      position = Vector2.zero();
    }
    
    if (_rainAnimation != null) {
      _rainAnimation!.size = gameRef.size;
    }
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    _resizeToFullScreen();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _cycleTimer?.update(dt);
  }

  @override
  void onRemove() {
    _cycleTimer?.stop();
    _removeRainAnimation();
    super.onRemove();
  }
}
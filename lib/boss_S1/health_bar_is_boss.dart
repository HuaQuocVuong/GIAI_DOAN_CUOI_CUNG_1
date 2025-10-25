import 'package:flame/components.dart';

import 'package:flutter/material.dart';

import 'package:update1/boss_S1/boss1.dart';

/// Thanh máu cho Boss - sử dụng ảnh sprite
class BossHealthBar extends PositionComponent {
  final Boss boss;
  bool _spritesLoaded = false;
  late Sprite _currentHealthSprite;

  // Các sprite cho từng mức máu
    late final Sprite _health0;
    late final Sprite _health20;
    late final Sprite _health25;
    late final Sprite _health30;
    late final Sprite _health35;
    late final Sprite _health40;
    late final Sprite _health45;
    late final Sprite _health50;
    late final Sprite _health55;
    late final Sprite _health60;
    late final Sprite _health65;
    late final Sprite _health70;
    late final Sprite _health75;
    late final Sprite _health80;
    late final Sprite _health85;
    late final Sprite _health90;
    late final Sprite _health95;
    late final Sprite _health100;

  BossHealthBar({required this.boss}) : super(
    //position: Vector2(0, 0),
    size: Vector2(200, 90), // Kích thước lớn hơn cho boss
    anchor: Anchor.topCenter,
    
  );
  

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await loadHealthSprites();
  }

  // Phương thức tải tất cả sprite
  Future<void> loadHealthSprites() async {
    _health0= await Sprite.load('tg_heathbar18.png');
    _health20= await Sprite.load('tg_heathbar17.png');
    _health25= await Sprite.load('tg_heathbar16.png');
    _health30= await Sprite.load('tg_heathbar15.png');
    _health35= await Sprite.load('tg_heathbar14.png');
    _health40= await Sprite.load('tg_heathbar13.png');
    _health45= await Sprite.load('tg_heathbar12.png');
    _health50= await Sprite.load('tg_heathbar11.png');
    _health55= await Sprite.load('tg_heathbar10.png');
    _health60= await Sprite.load('tg_heathbar9.png');
    _health65= await Sprite.load('tg_heathbar8.png');
    _health70= await Sprite.load('tg_heathbar7.png');
    _health75= await Sprite.load('tg_heathbar6.png');
    _health80= await Sprite.load('tg_heathbar5.png');
    _health85= await Sprite.load('tg_heathbar4.png');
    _health90= await Sprite.load('tg_heathbar3.png');
    _health95= await Sprite.load('tg_heathbar2.png');
    _health100= await Sprite.load('tg_heathbar1.png');
    _currentHealthSprite = _health100;
    _spritesLoaded = true;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (boss.isMounted && _spritesLoaded && boss.isAlive) {
      // Cập nhật sprite theo máu hiện tại
      _updateHealthSprite();
      
      // Vẽ sprite máu
      _currentHealthSprite.render(canvas, size: size);
    }
    // Nếu chưa tải được sprite hoặc boss đã chết thì không vẽ gì cả
  }

  // Cập nhật sprite theo tỉ lệ máu
void _updateHealthSprite(){
final healthRatio=boss.health/boss.maxHealth;
final percentage=(healthRatio*100).ceil();
if(percentage>=97){
  _currentHealthSprite=_health100;
}else if(percentage>=93){
  _currentHealthSprite=_health95;
}else if(percentage>=88){
  _currentHealthSprite=_health90;
}else if(percentage>=83){
  _currentHealthSprite=_health85;
}else if(percentage>=78){
  _currentHealthSprite=_health80;
}else if(percentage>=73){
  _currentHealthSprite=_health75;
}else if(percentage>=68){
  _currentHealthSprite=_health70;
}else if(percentage>=63){
  _currentHealthSprite=_health65;
}else if(percentage>=58){
  _currentHealthSprite=_health60;
}else if(percentage>=53){
  _currentHealthSprite=_health55;
}else if(percentage>=48){
  _currentHealthSprite=_health50;
}else if(percentage>=43){
  _currentHealthSprite=_health45;
}else if(percentage>=38){
  _currentHealthSprite=_health40;
}else if(percentage>=33){
  _currentHealthSprite=_health35;
}else if(percentage>=28){
  _currentHealthSprite=_health30;
}else if(percentage>=23){
  _currentHealthSprite=_health25;
}else if(percentage>=15){
  _currentHealthSprite=_health20;
}else if(percentage>0){
  _currentHealthSprite=_health20;
}else{
  _currentHealthSprite=_health0;
}
}

   

  @override
  void update(double dt) {
    super.update(dt);

    if (boss.isMounted && boss.isAlive) {

      position = Vector2(
        boss.position.x,
         boss.position.y - boss.size.y / 2 - 50 
      );
    }
  }
}

import 'package:flame/game.dart';
import 'package:update1/Teleportation_Stone/handlings_teleportation_stone.dart';
import 'package:update1/boss_S2/health_bar_is_boss2.dart';

import 'package:update1/main.dart';

import 'package:update1/processing_function/my_game.dart';

import 'package:update1/MAP/map_forest/forest_decor_manager.dart';
import 'package:update1/MAP/map_poisonouns_forest/poisonouns_forest_decor_manager.dart';
import 'package:update1/MAP/tree_manager_base.dart';
import 'package:update1/MAP/map_forest/forest_tree_manager.dart';
import 'package:update1/MAP/map_poisonouns_forest/poisonous_forest_tree_manager.dart';

import 'package:update1/boss_S1/handlings_boss1.dart';
import 'package:update1/boss_S1/health_bar_is_boss1.dart';

import 'package:update1/boss_S2/handlings_boss2.dart';


import 'package:update1/MAP/status_maps/map_status.dart';
import 'package:update1/MAP/tree_animation.dart';

enum GameMapType {
  forest,
  poisonousforest,
}

class MapManager {
  final MyGame game;
  GameMapType currentMap = GameMapType.forest;
  BackgroundComponent? _background;

  Boss? _currentBoss;
  BossHealthBar? _currentBossHealthBar;

  Boss2? _currentBoss2;

  // Khai báo các tree manager
  final ForestTreeManager _forestTreeManager = ForestTreeManager();
  final PoisonousForestTreeManager _poisonousTreeManager = PoisonousForestTreeManager();
  
  MapManager(this.game);
  
  Future<void> switchMap(GameMapType newMap) async {
    await _removeCurrentMap();
    currentMap = newMap;
    await _loadNewMap();
  }
  
  Future<void> _removeCurrentMap() async {

     // XÓA TẤT CẢ ĐÁ DỊCH CHUYỂN KHI CHUYỂN MAP
    final stones = game.children.whereType<TeleportationStone>().toList();
    for (final stone in stones) {
      stone.removeFromParent();
    }

    // REMOVE TẤT CẢ CÂY TRƯỚC KHI CHUYỂN MAP
    final trees = game.children.whereType<TreeComponent>().toList();
    for (final tree in trees) {
      tree.removeFromParent();
    }
    // Chờ một frame để đảm bảo trees đã được remove
    await Future.delayed(Duration.zero);

    // Remove decor theo map hiện tại
    switch (currentMap) {
      case GameMapType.forest:
        await ForestDecorManager.removeDecorFromGame(game);
        break;
      case GameMapType.poisonousforest:
        await PoisonousDecorManager.removeDecorFromGame(game);
        break;
    }
    
    // XOÁ BOSS KHI CHUYỂN SANG MAP KHÁC
    if (_currentBoss != null) {
      _currentBoss!.removeFromParent();
      _currentBoss = null;
    }

    // THÊM XÓA BOSS2
    if (_currentBoss2 != null) {
      _currentBoss2!.removeFromParent();
      _currentBoss2 = null;
    }

    if (_currentBossHealthBar != null) {
      _currentBossHealthBar!.removeFromParent();
      _currentBossHealthBar = null;
    }
  }

  
  Future<void> _loadNewMap() async {
    switch (currentMap) {
      case GameMapType.forest:
        await _loadForestMap();
        break;
      case GameMapType.poisonousforest:
        await _loadPoisonousForestMap();
        break;
    }
  }
  
  //MAP FOREST
  Future<void> _loadForestMap() async {
    if (_background == null) {
      // Tạo background lần đầu - map rừng thường
      _background = BackgroundComponent(initialMap: MapType.forest);
      await game.add(_background!);
    } else {
      // Chuyển map cho background hiện tại
      await _background!.changeMap(MapType.forest);
    }

    // Thêm cây cho map rừng thường - SỬ DỤNG TREE MANAGER MỚI
    await _forestTreeManager.addTreesToGame(game);

    // THÊM DECOR CHO FOREST MAP (Hiện tại chưa có)
    await ForestDecorManager.addDecorToGame(game);


 
    
    // THÊM BOSS CHỈ Ở FOREST
    _currentBoss = Boss(
      position: Vector2(1700, 300),
      size: Vector2(350, 350),
    );

    await game.add(_currentBoss!);                                                                      //<-- Tạm ẩn boss để test

    _currentBossHealthBar = BossHealthBar(boss: _currentBoss!);
    await game.add(_currentBossHealthBar!);
  }

  //MAP POISONOUS FOREST
  Future<void> _loadPoisonousForestMap() async {
    
    if (_background == null) {
      _background = BackgroundComponent(initialMap: MapType.poisonousforest);
      await game.add(_background!);
    } else {
      await _background!.changeMap(MapType.poisonousforest);
    }

    // Thêm cây cho map rừng độc - SỬ DỤNG TREE MANAGER MỚI
    await _poisonousTreeManager.addTreesToGame(game);
    

    // THÊM DECOR NƯỚC VÀO POISONOUS FOREST MAP
    await PoisonousDecorManager.addDecorToGame(game);

    // THÊM BOSS CHỈ Ở FOREST
    _currentBoss2 = Boss2(
      position: Vector2(1700, 300),
      size: Vector2(350, 350),
    );
    
    await game.add(_currentBoss2!);                                                                    //<-- Tạm ẩn boss để test
  }
}


import 'package:flame/game.dart';
import 'package:update1/processing_function/my_game.dart';

class PauseMenu {
  final MyGame game;
  bool _isVisible = false;

  PauseMenu({required this.game});

  void showMenu() {
    if (!_isVisible) {
      _isVisible = true;
      game.pauseEngine();

    }
  }

  void hideMenu() {
    if (_isVisible) {
      _isVisible = false;
      game.resumeEngine();
    }
  }

  void toggleMenu() {
    if (_isVisible) {
      hideMenu();
    } else {
      showMenu();
    }
  }

  bool get isVisible => _isVisible;
}
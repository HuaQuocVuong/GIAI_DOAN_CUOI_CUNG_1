// audio_manager.dart
import 'package:flame_audio/flame_audio.dart';
import 'package:update1/MAP/map_manager.dart';

class AudioManager {

  // Biến static để lưu track nhạc hiện tại đang phát
  static String? currentTrack;
  
  // Mỗi GameMapType sẽ có một file nhạc nền riêng
  static final Map<GameMapType, String> _mapMusic = {
    GameMapType.forest: 'Alicization-War-of-Underworld.mp3',
    GameMapType.poisonousforest: 'Running-Out-of-Crisis-Yuki-Kajiura.mp3',
  };

  // Hàm chính để phát nhạc nền cho map
  static Future<void> playMapMusic(GameMapType mapType) async {
    // Lấy file nhạc tương ứng với map type từ map
    final String newTrack = _mapMusic[mapType]!;
    
    // Chỉ thay đổi nếu nhạc mới khác nhạc hiện tại
    if (currentTrack != newTrack) {
      await stopMusic();  // Dừng nhạc hiện tại trước khi phát nhạc mới
      await FlameAudio.bgm.play(newTrack);  // Phát nhạc nền mới (bgm = background music)
      currentTrack = newTrack;   // Cập nhật track hiện tại
    }
  }

  // Hàm tạm dừng nhạc nền
  static Future<void> stopMusic() async {
    if (currentTrack != null) {
      await FlameAudio.bgm.stop();
      currentTrack = null;
    }
  }

  // Hàm tạm dừng nhạc nền (không reset currentTrack)
  static void pauseMusic() {
    FlameAudio.bgm.pause();
  }

  // Hàm tiếp tục phát nhạc nền sau khi tạm dừng
  static void resumeMusic() {
    FlameAudio.bgm.resume();
  }
  
  // Hàm phát hiệu ứng âm thanh (sound effect)
  static Future<void> playSoundEffect(String sound) async {
    await FlameAudio.play(sound);
  }
}
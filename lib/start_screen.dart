import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:update1/processing_function/my_game.dart';

// Màn hình khởi động/trang chủ của game
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  // Trạng thái kiểm tra game đã bắt đầu chưa
  bool _gameStarted = false;

  // Hàm bắt đầu game
  void _startGame() {
    setState(() {
      FlameAudio.play('link-start.mp3');  // Phát âm thanh khi bắt đầu game
      _gameStarted = true;  // Chuyển trạng thái sang đã bắt đầu game
    });
  }

  @override
  Widget build(BuildContext context) {
    // Nếu game đã bắt đầu, hiển thị màn hình game chính
    if (_gameStarted) {
      return GameWidget(game: MyGame());  // Widget game từ Flame
    } 

     // Nếu game chưa bắt đầu, hiển thị màn hình khởi động
    return Scaffold(
      body: Container(

        // Background với ảnh GIF động
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/screeen_game11.gif'), // Ảnh nền động
            fit: BoxFit.cover,  // Che phủ toàn bộ màn hình
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // Căn giữa theo chiều dọc
            children: [
              // Logo game - ảnh GIF động
               SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6, // Chiếm 90% chiều rộng màn hình
                  height: MediaQuery.of(context).size.height * 0.3, // Chiếm 60% chiều cao màn hình
                  child: Image.asset(
                    'assets/images/logo_game.gif', 
                  fit: BoxFit.contain, // Giữ tỷ lệ gốc của ảnh

                  ),
               ),
               const SizedBox(height: 40), // Khoảng cách 40px giữa logo và nút
              
              // Nút bắt đầu game - Ảnh có thể nhấn
              GestureDetector(
                onTap: _startGame, // Gọi hàm bắt đầu game khi nhấn
                child: Image.asset(
                  'assets/images/Enter_play1.png',  // Ảnh nút bắt đầu
                  width: 501,  // Chiều rộng cố định 200px
                  height: 61, // Chiều cao cố định 80px
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
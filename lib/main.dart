import 'package:flame/game.dart'; //Cung cấp GameWidget: cầu nối Flame  Flutter

import 'package:flutter/material.dart'; //Thư viện Flutter cơ bản (widget, runApp...)

import 'package:update1/start_screen.dart';  // Import game chính mà bạn đã tạo (MyGame)

import 'package:update1/processing_function/my_game.dart';



//Hàm main(): điểm khởi đầu của ứng dụng Flutter.
//Tạo instance của MyGame (lớp game chính).
//Gắn MyGame vào GameWidget để hiển thị trong Flutter.
//Dùng runApp để render toàn bộ game ra màn hình.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartScreen(), // Dùng StartScreen(Màn hình khởi động game)
    );
  }
} 
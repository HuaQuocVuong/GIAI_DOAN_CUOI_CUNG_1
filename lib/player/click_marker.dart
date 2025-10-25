import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:flutter/material.dart';


//Lớp ClickMarker: tạo hiệu ứng vòng tròn nhỏ tại vị trí người chơi click.
//Kế thừa CircleComponent: hiển thị hình tròn.
//Khi được tạo, nó sẽ nháy màu và mờ dần, sau đó tự động biến mất.
class ClickMarker extends CircleComponent {
  // Constructor:
  //position: vị trí click trên màn hình (tọa độ Vector2).
  //tankRadius: bán kính của xe tăng (dùng để tính kích thước marker nhỏ hơn).
  ClickMarker(Vector2 position, double tankRadius)
  :super (
    //1. Bán kính marker = 50% bán kính xe tăng
    radius: tankRadius * 0.2, 
    
    //2. Neo (anchor) = center → tâm vòng tròn trùng với position
    anchor: Anchor.center,

    //3. Vị trí xuất hiện = vị trí click
    position: position,

     //4. Cấu hình paint: chỉ vẽ viền, màu xanh dương 
    paint: Paint()
    ..style = PaintingStyle.stroke //Không tô bên trong
    ..strokeWidth = 2 //Độ dày viền = 2px
    ..color = Colors.blueAccent, //Màu viền
     
  ) {
  //Hiệu ứng nháy của ClickMarker
    
    //Nháy sáng
    add (
      ColorEffect(
        Colors.lightBlueAccent,
        EffectController (
          duration: 0.3,  //thời gian mỗi lần là 0.2s
          repeatCount: 2, //Lặp 2 lần 
          //Tổng CLickMarker tồn tại 0.4s
          //Xen kẽ màu gốc BlueAccent và lightBlueAccent
          alternate: true,
        ),
      ),
    );
    //Fade Out (Mờ dần rồi mất)
    add (
      OpacityEffect.to(
        0.0, // opacity về 0 trở nên trong suốt
        EffectController(duration: 1.5), //Trong 0.8s
        
        // Sau khi hiệu ứng kết thúc thì xóa khỏi cây component
        onComplete: () {
          removeFromParent();
        },
      ),
    );
  }
}

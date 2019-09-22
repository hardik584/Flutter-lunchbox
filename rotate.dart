import 'dart:math' as math; // import this

Transform(
  alignment: Alignment.center,
  transform: Matrix4.rotationY(math.pi),
  child: Icon(Icons.rotate_left, size: 100,),
)
//https://stackoverflow.com/questions/58047009/flutter-how-to-flip-an-icon-to-get-mirror-effect
//https://i.stack.imgur.com/GM2a8.png
//https://i.stack.imgur.com/JHk4Z.png

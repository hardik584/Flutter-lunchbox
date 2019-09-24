https://www.youtube.com/watch?v=sb92CI312oQ


import 'package:flutter/material.dart';
 

class WheelExample extends StatefulWidget {
  @override
  _WheelExampleState createState() => _WheelExampleState();
}

class _WheelExampleState extends State<WheelExample> with SingleTickerProviderStateMixin{
  int a;
  AnimationController anime;
  bool isplaying = true;

  @override
  void initState() {
    super.initState();
   anime = AnimationController(duration: Duration(milliseconds: 600),vsync: this);

  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wheel'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){
            anime.forward();
          },
          onDoubleTap: (){
            anime.reverse();
          },
                  child: Container(
            child: AnimatedIcon(icon: AnimatedIcons.arrow_menu,progress: anime,size: 45,),
          ),
        ),
      ),
    );
  }
}

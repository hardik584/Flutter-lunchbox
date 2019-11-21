import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AppBarScreen extends StatefulWidget {
  AppBarScreen({Key key}) : super(key: key);

  @override
  _AppBarScreenState createState() => _AppBarScreenState();
}

class _AppBarScreenState extends State<AppBarScreen> {
  DateTime time = DateTime.now();
  double height = 40, width = 150;
  final controller = ScrollController();
  String abc = "";
  int s = 0;
  @override
  void initState() {
    super.initState();

    controller.addListener(onScroll);
  }

  onScroll() {
    setState(() {
      if (controller.offset >= 5) {
        print(controller.offset);
        height = 5;
        setState(() {});
      } else if (controller.offset <= 20) {
        height = 40;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return SafeArea(
                child: Stack(
                  children: <Widget>[
                    Scaffold(
                      backgroundColor: Color.fromRGBO(14, 18, 49, 1.0),
                      body: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ListView.builder(
                          itemCount: 100,
                          controller: controller,
                          itemBuilder: (context, i) {
                            return ListTile(
                              title: Text(
                                i.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                          //  List.generate(
                          //       100,
                          //       (index) => ListTile(
                          //             title: Text(index.toString(),style: TextStyle(color: Colors.white),),
                          //           )),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      child: AppBar(
                        backgroundColor: Color.fromRGBO(23, 46, 70, 1),
                        title: Text('data'),
                      ),
                    ),
                    AnimatedContainer(
                      margin: EdgeInsets.zero,
                      height: 100,
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: height),
                      width: MediaQuery.of(context).size.width,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.zero,
                        width: 50,
                        decoration: BoxDecoration(
                           border: Border.all(color:height == 40? Color.fromRGBO(14, 18, 49, 1.0):Colors.transparent ,width:5, ),
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjjLHxsywm_DIt0UYfQv2KNudOzn_Wdqr05Ey6Xcuhrjlz7NDIwA&s"),
                            
                          ),
                        ),
                        child: Text(''),
                      ),
                      decoration: BoxDecoration(
                          // color: Colors.amber,
                          // shape: BoxShape.circle
                          ),
                    )
                  ],
                ),
              );
            }));
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text('data'),

    //       flexibleSpace: Stack(
    //         overflow: Overflow.visible,
    //         children: <Widget>[
    //           // Text('data')
    //           Container(
    //             color: Colors.red,
    //             padding: EdgeInsets.only(top: 150),
    //             child: Text('data'),
    //           )
    //         ],
    //       ),
    //     ),
    //     body: AnimatedBuilder(
    //       animation:  controller,
    //       builder: (context,child){
    //               return Stack(
    //                 alignment: Alignment.center,
    //   children: <Widget>[

    //   //     Scaffold(
    //   //       backgroundColor: Colors.transparent,
    //   //       body:Padding(
    //   //         padding: const EdgeInsets.only(top:20.0),
    //   //         child: ListView(
    //   //           controller: controller,
    //   //   children: List.generate(
    //   //         200,
    //   //         (index) => ListTile(
    //   //               title: Text(index.toString()),
    //   //             )),
    //   // ),
    //   //       ),
    //   //     ),
    //        Positioned(
    //         top: 20,
    //         // left: 50,
    //         // right: 50,
    //         child: AnimatedContainer(
    //           width: width,
    //           height: height,
    //           decoration: BoxDecoration(
    //             color: Colors.red,
    //             // borderRadius: _borderRadius,
    //           ),
    //           duration: Duration(seconds: 1),
    //           curve: Curves.fastOutSlowIn,
    //         ),
    //       ),
    //   ],
    // );}
    //     ));
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 20;
    while (curXPos < size.width) {
      curXPos += increment;
      path.arcToPoint(Offset(curXPos, curYPos), radius: Radius.circular(5));
    }
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

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
       if(controller.offset >= 50){
      print(controller.offset);
      height = 5;
      setState(() {});
    }
    else if(controller.offset <= 50){
      height = 40;
      setState(() {});
    }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation:  controller,
          builder: (context,child){return SafeArea(
              child: Stack(
          children: <Widget>[
             Scaffold(
            backgroundColor: Colors.transparent,
            body:Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: ListView(
                controller: controller,
        children: List.generate(
              200,
              (index) => ListTile(
                    title: Text(index.toString()),
                  )),
      ),
            ),
          ),
            Container(
              height: 60,
              child: AppBar(
                title: Text('data'),
              ),
            ),
            AnimatedContainer(
              height: 100,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: height),
              width: MediaQuery.of(context).size.width,
              duration: Duration(milliseconds: 400),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color:height <= 5 ?  Colors.transparent:Colors.white ,width:5),
                  shape: BoxShape.circle,
                  color: Colors.red
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
          })
    );
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

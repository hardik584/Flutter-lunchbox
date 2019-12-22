https://stackoverflow.com/questions/51117958/how-to-take-a-screenshot-of-the-current-widget-flutter

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:work_organizer/screen/drawer_screen.dart';
import 'package:work_organizer/util/app_style.dart';

class WorkHourScreen extends StatefulWidget {
  WorkHourScreen({Key key}) : super(key: key);

  @override
  _WorkHourScreenState createState() => _WorkHourScreenState();
}

class _WorkHourScreenState extends State<WorkHourScreen> {
  var scr= new GlobalKey();
  var pngBytes;
  takescrshot() async {
  RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
  var image = await boundary.toImage();
  var byteData = await image.toByteData(format: ImageByteFormat.png);
     pngBytes= byteData.buffer.asUint8List();
  print(pngBytes);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Workhours List",
          style: AppStyle.largeTextStyle(),
        ),
        centerTitle: true,
      ),
      drawer: DrawerScreen(),
      body: Column(
        children: <Widget>[
          RepaintBoundary(
                key: scr,
                              child: Card(
                  // key: Key(index.toString()),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(

                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Workhour",style: AppStyle.mediumTextStyle(),),
                            Text("1")
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
               Image.memory(pngBytes) ,
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: 10,
          //   itemBuilder: (context, index) {
          //     return RepaintBoundary(
          //       key: scr,
          //                     child: Card(
          //         // key: Key(index.toString()),
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Column(

          //             children: <Widget>[
          //               Row(
          //                 children: <Widget>[
          //                   Text("Workhour",style: AppStyle.mediumTextStyle(),),
          //                   Text("$index")
          //                 ],
          //               ),
                        
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          RaisedButton(
            onPressed: (){takescrshot();setState(() {
              
            });},
            child: Text("Click ss"),
          ),
        ],
      ),
    );
  }
}


  takeScreenShot() async{
    RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile =new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
  }
 

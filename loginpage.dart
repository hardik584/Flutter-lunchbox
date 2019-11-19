import 'package:cocktail/themes/appcolor.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            right: 0,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.colorPink,
                    AppColor.colorPink.withOpacity(0.7)
                  ]
                ),
                  //color: AppColor.colorPink,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(800))),
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.colorOrange.withOpacity(0.7),
                    AppColor.colorOrange,
                  ]
                ),
                  //color: AppColor.colorPink,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(800))),
            ),
          ),
          Positioned(
            bottom:  -50,
            right: 0,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [
                //     AppColor.colorOrange,
                //     AppColor.colorOrange.withOpacity(0.7)
                //   ]
                // ),
                   color: AppColor.colorPinkLight,
                  borderRadius:
                      BorderRadius.only(topLeft:  Radius.circular(1000))),
            ),
          ),
          Positioned(
            bottom:  -130,
            right: 50,
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.colorOrangeLight,
                    AppColor.colorOrangeLight.withOpacity(0.7)
                  ]
                ),
                   color: AppColor.colorOrangeLight,
                  borderRadius:
                      BorderRadius.all( Radius.circular(1000))),
            ),
          ),
          Container(
            child: Center(child: Text("Hello\nWorld",style: TextStyle(fontSize: 100, decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.dotted,),)),
          ),
        ],
      ),
    );
  }
}
 

class AppColor
{
  static Color colorPink = Color.fromRGBO(238, 86, 125, 1.0);
  static Color colorOrange = Color.fromRGBO(254,172, 125, 1.0);
  static Color colorPinkLight = Color.fromRGBO(254,227, 236, 1.0);
  static Color colorOrangeLight = Color.fromRGBO(228,209, 204, 1.0);
}

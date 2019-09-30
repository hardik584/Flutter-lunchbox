//It's my first showcase of animation
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onprowork/screens/LoginPage.dart';
import 'package:onprowork/utils/Colors.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation, delayedAnimation, muchDelayedAnimation, floatAnimation;

 
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
      //reverseCurve: Curves.bounceIn
    ));
    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(0.5, 1.0, curve: Curves.easeOutSine),
        parent: _controller));
    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(0.5, 1.0, curve: Curves.easeOutSine),
        parent: _controller));

    floatAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.3, 0.5, curve: Curves.slowMiddle),
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mHeight = MediaQuery.of(context).size.height;
    var mWidth = MediaQuery.of(context).size.width;
    print(mHeight);
    print(mWidth);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, Widget w) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: AppColors.colorBackground,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Transform(
                        transform: Matrix4.translationValues(
                            0.0,  animation.value * mWidth, 0.0),
                                          child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 35,
                            ),
                            children: [
                              TextSpan(text: "ONPRO"),
                              TextSpan(
                                text: "WORK",
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 71, 71, 1.0),
                                ),
                              )
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: mHeight * 0.10,
                    ),
                    Transform(
                         transform: Matrix4.translationValues(
                            0.0,  -animation.value * mWidth, 0.0),
                                          child: Text(
                        "Online Challenges Platform for Creative Designers and developers",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
**********************************************************************************************************************

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
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        //fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            right: 0,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColor.colorPink,
                  AppColor.colorPink.withOpacity(0.7)
                ]),
                //backgroundBlendMode: BlendMode.exclusion,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: AppColor.colorPink.withOpacity(0.3),
                    spreadRadius: 2,
                    offset: Offset(10, 20),
                  )
                ],

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(800),
                ),
              ),
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
                    AppColor.colorOrange.withOpacity(1.0),
                    AppColor.colorOrange,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: AppColor.colorOrange.withOpacity(0.3),
                    spreadRadius: 2,
                    offset: Offset(-18, 20),
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(800),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: 0,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: AppColor.colorPink.withOpacity(0.2),
                    spreadRadius: 2,
                    offset: Offset(12, -20),
                  )
                ],
                color: AppColor.colorPinkLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(1000),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -130,
            right: 50,
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.colorOrangeLight,
                    AppColor.colorOrangeLight.withOpacity(0.7)
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: AppColor.colorOrange.withOpacity(0.2),
                    spreadRadius: 2,
                    offset: Offset(-14, -10),
                  )
                ],
                color: AppColor.colorOrangeLight,
                borderRadius: BorderRadius.all(
                  Radius.circular(1000),
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: NetworkImage(
                                "https://www.infilon.com/wp-content/uploads/2018/05/favicon.png",
                              ),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 15,
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "USERNAME",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    TextField(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "PASSWORD",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          suffixText: "Forgot Password",
                          suffixStyle: TextStyle(
                              color: AppColor.colorPink,
                              fontWeight: FontWeight.w500)
                          //suffixIcon: Text("Forgot Password")
                          ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        elevation: 10,
                        onPressed: () {},
                        color: AppColor.colorPink,
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "New to friendly Desi?",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20)),
                          TextSpan(text: "   "),
                          TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                  color: AppColor.colorPink, fontSize: 20)),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppColor {
  static Color colorPink = Color.fromRGBO(238, 86, 125, 1.0);
  static Color colorOrange = Color.fromRGBO(254, 172, 125, 1.0);
  static Color colorPinkLight = Color.fromRGBO(254, 227, 236, 1.0);
  static Color colorOrangeLight = Color.fromRGBO(228, 209, 204, 1.0);
}

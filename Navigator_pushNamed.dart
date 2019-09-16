
//main.dart


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:jarvis/route_generator.dart';

import 'Jarvis.dart';
import 'database_helper_sqflite.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Map abc = {"fname": "Aes", "lname": "Patel"};
            Navigator.pushNamed(context, '/secondPage', arguments: abc);
          },
          child: Text("Second Page"),
        ),
      ),
    );
  }
}

class ThirdPage extends StatefulWidget {
  final Datum data;
  ThirdPage({this.data, Key key}) : super(key: key);

  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(widget.data.avatar),
            Text(widget.data.email),
            Text(widget.data.firstName),
            Text(widget.data.lastName),
            Text(widget.data.id.toString()),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final String fname;
  final String lname;
  SecondPage({this.lname, this.fname, Key key}) : super(key: key);

  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Column(
        children: <Widget>[
          Text(
            widget.fname + widget.lname,
            style: TextStyle(fontSize: 50),
          ),
          OutlineButton(
            child: Text("Third Page"),
            onPressed: () {
              Navigator.pushNamed(context, '/thirdPage',
                  arguments: Datum(
                      avatar: "jihdgksd;olgkjfdls;oak",
                      email: "hdfjokdokgfddsf",
                      id: 2,
                      firstName: "hardik",
                      lastName: "kumbhani"));
            },
          )
        ],
      ),
    );
  }
}

//******************************************************************************************************************

//route_generator.dart

import 'package:flutter/material.dart';
import 'package:jarvis/Jarvis.dart';
import 'main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => FirstPage());
      case '/secondPage':
        if (args is Map) {
          return MaterialPageRoute(
              builder: (_) => SecondPage(
                    fname: args["fname"],
                    lname: args["lname"],
                  ));
        }
        return _errorRoute();
      case '/thirdPage':
      //remamber that Datum is PODO class
        if (args is Datum) {
          return MaterialPageRoute(
              builder: (_) => ThirdPage(
                    data: args,
                  ));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Error"),
        ),
      );
    });
  }
}

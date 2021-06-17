import 'dart:io';
import 'dart:convert';
 

import 'package:dio/dio.dart';
 
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class MyHttpOverrides extends HttpOverrides{
   @override
   HttpClient createHttpClient(SecurityContext? context){
     return super.createHttpClient(context)
       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
   }
 }
void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

   

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void _incrementCounter() {
    setState(() {
       
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
 
        title: Text(widget.title),
      ),
      body: Center(
 
        child: Column(
           
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
             
                ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DioTest()
                    ),
                  );
                },
                child: Text("Dio 3"))
          ],
        ),
      ),
 
    );
  }
}


class DioTest extends StatefulWidget {
  DioTest({Key? key}) : super(key: key);

  @override
  _DioTestState createState() => _DioTestState();
}

class _DioTestState extends State<DioTest> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callDioApiCall();
  }

  Future<void> callDioApiCall()async {
    Dio dio = new Dio(); 
 var onHttpClientCreate =
     (HttpClient client) {
   client.badCertificateCallback =
       (X509Certificate cert, String host, int port) => true;
   return client;
 };
  var _client = new HttpClient();
     _client.badCertificateCallback =
         (X509Certificate cert, String host, int port) => true;
         bool _certificateCheck(X509Certificate cert, String host, int port) =>
     host == 'local.domain.ext'; // <- change

 HttpClient client = new HttpClient()
     ..badCertificateCallback = (_certificateCheck);
  //  Response response =await  Dio().get("https://node-api-jahaaj.herokuapp.com");
    Map<String,dynamic> map = {"username":"sadads","password":"asdasda","device_id":"706cd586e3a3a1a5","os":"1","fcm_token":"","device_info":"Google","model_name":"sdk_gphone_x86_arm"};
    Response response = await dio.post("https://api.lawcanvas.in:8046/api/account/sign-in",data: jsonEncode(map));
   print(response.data);
   print(response.statusCode);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

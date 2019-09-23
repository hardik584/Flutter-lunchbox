import 'package:flutter/material.dart';
void main() => runApp(Home());
class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Text("Helo World!"),
      ),
    );
  }
}

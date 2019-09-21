import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> animalName = ["Lion", "Tiger", "Horse", "Pig", "Dog"];
  List<String> animalUrl = [
    "lion.jpg",
    "tiger.jpg",
    "horse.jpg",
    "pig.jpg",
    "dog.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Animal List'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: animalName.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(animalName[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AnimalPage(
                              animalUrl: animalUrl[index],
                              title: animalName[index],
                              text: "this is a ${animalName[index]}",
                            )),
                  );
                });
          },
        ),
      ),
    );
  }
}

class AnimalPage extends StatefulWidget {
  final String text, title, animalUrl;
  AnimalPage({this.title, this.text, this.animalUrl});
  @override
  _AnimalPageState createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: <Widget>[
        SizedBox(
            height: 200.0,
            width: 200.0,
            child: Image.asset(
              widget.animalUrl,
            )),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Wrap(
          children: <Widget>[
            Center(
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        )
      ]),
    );
  }
}

 

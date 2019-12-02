// add below code in pubspec.yaml file
module:
  androidX: true
firebase_ml_vision: ^0.9.3+3
image_picker: ^0.6.2+1

//If you got error in your project then read this link
https://github.com/hardik584/Flutter-lunchbox/blob/master/gradlefileerror.gradle

import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextReco extends StatefulWidget {
  TextReco({Key key}) : super(key: key);

  @override
  _TextRecoState createState() => _TextRecoState();
}

class _TextRecoState extends State<TextReco> {
  File _image;

  String text;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
    readText().then((onValue) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(onValue),
            );
          });
    });
  }

  Future<String> readText() async {
    text = "";

    FirebaseVisionImage ourimage = FirebaseVisionImage.fromFile(_image);
    TextRecognizer reconizetext = FirebaseVision.instance.textRecognizer();
    VisionText readtext = await reconizetext.processImage(ourimage);

    for (TextBlock block in readtext.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          // print(word.text);

          text += word.text + " ";
          print(text);
        }
      }
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Reco"),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pwidget;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart' as pdfw;

void main() => runApp(MyApp());

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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  File imagePick;
  var scr = new GlobalKey();
  Future<Uint8List> takeScreenShot() async {
    RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();

    var image = await boundary.toImage(pixelRatio: 10.0);

    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  }

  void _showQRandPrint() async {
    Dio dio = Dio();

    var dirToSave = await getApplicationDocumentsDirectory();

    await dio
        .download(
            "https://inducesmile.com/wp-content/uploads/2019/09/survey.png",
            "${dirToSave.path}/myImage.jpg",
            onReceiveProgress: (rec, total) {})
        .then((onValue) {});
    //  File netImg = File("${dirToSave.path}/myImage.jpg");
    final netImg =
        decodeImage(File("${dirToSave.path}/myImage.jpg").readAsBytesSync());
    File imagepick =
        File("/storage/emulated/0/BizBox/11_1000151_1528288212591.jpg");
    final img = decodeImage(
        File('/storage/emulated/0/BizBox/11_1000151_1528288212591.jpg')
            .readAsBytesSync());
    final RenderRepaintBoundary boundary =
        scr.currentContext.findRenderObject();
    var im = await boundary.toImage(pixelRatio: 10.0);
    final ByteData bytes = await im.toByteData(format: ImageByteFormat.rawRgba);
    ////////////////////////////////////////////////////////////////////////////
    final pwidget.Document document = pwidget.Document();

    final PdfImage image = PdfImage(document.document,
        image: bytes.buffer.asUint8List(), width: im.width, height: im.height);

    final PdfImage image1 = PdfImage(document.document,
        image: img.data.buffer.asUint8List(),
        width: img.width,
        height: img.height);
    final PdfImage image2 = PdfImage(document.document,
        image: netImg.data.buffer.asUint8List(),
        width: netImg.width,
        height: netImg.height);

    document.addPage(pwidget.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pwidget.Context context) {
          return pwidget.Center(
            child: pwidget.Expanded(
              child: pwidget.Image(image),
            ),
          ); // Center
        })); // Page
    document.addPage(pwidget.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pwidget.Context context) {
          return pwidget.Center(
            child: pwidget.Expanded(
              child: pwidget.Image(image1),
            ),
          ); // Center
        }));
          document.addPage(pwidget.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pwidget.Context context) {
          return pwidget.Center(
            child: pwidget.Expanded(
              child: pwidget.Image(image2),
            ),
          ); // Center
        }));
    // return document.save();
    /////////////////////////////////////////////////////////////
    final bool result =
        await Printing.layoutPdf(onLayout: (PdfPageFormat format) {
      return document.save();
    });
  }

  void _incrementCounter() async {
    ImagePicker.pickImage(
      source: ImageSource.gallery,
    ).then((a) async {
      imagePick = a;
      print(imagePick.absolute.uri);
      setState(() {});
      // RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();

      // var imagee = await boundary.toImage(pixelRatio: 10.0);

      // ByteData byteData =
      //     await imagee.toByteData(format: ImageByteFormat.rawRgba);
      // final pdf = new PDFDocument();
      // final page = new PDFPage(pdf, pageFormat: PDFPageFormat(75.0, 100.0));
      // final g = page.getGraphics();
      // // final font = new PDFFont(pdf);

      // PDFImage image = new PDFImage(pdf,
      //     image: byteData.buffer.asUint8List(), height: 200, width: 100);

      // g.drawImage(
      //     image, 100.0 * PDFPageFormat.MM, 0.0, 75.0 * PDFPageFormat.MM);

      // Printing.printPdf(document: pdf);
      // pwidget.Image a  = pwidget.Image(PdfImage(pdfDocument));
      //  pwidget.Image image = new   pwidget.Image(PdfAnnot.urlLink());

      // var pdf = pwidget.Document(pageMode: PdfPageMode.fullscreen);
      // pdf.addPage(pwidget.Page(build: (pwidget.Context context) {
      //   return pwidget.Center(
      //     child: pwidget.Image(PdfImage.jpeg(PDFDocument())),
      //   ); // Center
      // }));
      // final output = await getTemporaryDirectory();
      // final file = File("${output.path}/example.pdf");
      // await file.writeAsBytes(pdf.save());
      // Future.delayed(Duration(seconds: 2));
      // await Printing.sharePdf(bytes: pdf.save(), filename: 'my-document.pdf');
      // await Printing.layoutPdf(
      //     onLayout: (PdfPageFormat format) async => pdf.save());
    });

    // Printing.layoutPdf(onLayout: (a) async {
    //   return await Printing.convertHtml(
    //       html:
    //           '<html><body><img src="https://developer.android.com/topic/libraries/architecture/images/final-architecture.png" alt="Italian Trulli"> <img src="https://www.w3schools.com/images/w3schools_green.jpg" alt="W3Schools.com"></body></html>',
    //       format: PdfPageFormat.a4,
    //       baseUrl:
    //           "https://developer.android.com/topic/libraries/architecture/images/final-architecture.png");
    // });
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
      body: RepaintBoundary(
        key: scr,
        child: Container(
          color: Colors.indigo.withOpacity(.2),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Hello $index"),
                    );
                  },
                ),
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showQRandPrint,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

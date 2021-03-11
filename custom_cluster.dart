import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui show Image;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
ui.Image markerImage;
ui.Image clusterMarkerImage;
   ByteData bytes = await rootBundle.load("assets/image.png");
      markerImage = await decodeImageFromList(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

 ByteData bytes = await rootBundle.load("assets/cluster_image.png");
      clusterMarkerImage = await decodeImageFromList(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
      

Future<BitmapDescriptor> _getCustomMarkerBitmap(
      {int clusterCount = 0,
      bool isCluster = true,
      int size}) async {
  
    /// Init the [Canvas] and [PictureRecorder]
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()
      ..style = PaintingStyle.stroke;

    /// condition for marker background image
    ui.Image markerImage;
    if (isCluster) {
      markerImage = clusterMarkerImage; 
    } else {
      markerImage = markerImage;
    }
    /// For management of image marker with Rect
    final Size imageSize = Size(markerImage.width.toDouble(), markerImage.height.toDouble());
    final Rect src = Offset.zero & imageSize;
    final Rect dst = Offset.zero & const Size(125, 100);
    canvas.drawImageRect(markerImage, src, dst, paint1..blendMode = BlendMode.colorBurn);

    /// condition for marker text
    String markerText = '';
    if (isCluster) {
      markerText = clusterCount.toString();
    } else
      markerText = "hello flutter";
    }

    /// For the render text string in marker
    final TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: markerText,
      style: TextStyle(fontSize: size / 3.9, color: Palette.black, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    );
    painter.layout();
    painter.paint(canvas, Offset(size / 1.550 - painter.width / 2.22, size / 1.950 - painter.height / 0.80));

    /// For the convert canvas to [ui.Image]
    final ui.Image img = await pictureRecorder.endRecording().toImage(size, size);
    final ByteData data = await img.toByteData(format: ImageByteFormat.png);

    /// return BitmapDescriptor of marker
    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
}

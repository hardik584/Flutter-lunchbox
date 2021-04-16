  /// _getCustomMarkerBitmap
  /// This method is used to generate bitmap
  /// marker through custom painter
  Future<BitmapDescriptor> _getCustomMarkerBitmap(
      {
      int fuelTypeProductId,
      int clusterCount = 0,
      bool isCluster = true}) async {

    /// Init the [Canvas] and [PictureRecorder]
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..style = PaintingStyle.stroke;

    /// condition for marker background image
    ui.Image markerImage;
    if (isCluster) {
      markerImage = clusterMarkerImage;
    } else {
      markerImage = normalMarkerImage;
    }

    /// For management of image marker with Rect
    final Size imageSize =
        Size(markerImage.width.toDouble(), markerImage.height.toDouble());
    final Rect src = Offset.zero & imageSize;

    final Rect dst = Offset.zero & Size(imageSize.width, imageSize.height);
    canvas.drawImageRect(
        markerImage, src, dst, paint1..blendMode = BlendMode.colorBurn);

    /// condition for marker text
    String markerText = '';
    if (isCluster) {
      markerText = clusterCount.toString();
    } else {
      markerText = "146456.15546".toStringAsFixed(2);
    }

    /// For the render text string in marker
    final TextPainter painter = TextPainter(textDirection: TextDirection.ltr);

    painter.text = TextSpan(
      text: markerText,
      style: const TextStyle(
          fontSize: 34,
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontFamily: 'Lato'),
    );
    painter.layout();
    painter.paint(
        canvas,
        Offset(isCluster ? 120 : 130 - painter.width / 2.22, 67.10 - painter.height / 0.80));

    /// For the convert canvas to [ui.Image]
    final ui.Image img = await pictureRecorder
        .endRecording()
        .toImage(imageSize.width.toInt(), imageSize.height.toInt());
    final ByteData data = await img.toByteData(format: ImageByteFormat.png);

    /// return BitmapDescriptor of marker
    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

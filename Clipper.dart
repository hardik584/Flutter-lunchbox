https://iirokrankka.com/2017/09/04/clipping-widgets-with-bezier-curves-in-flutter/
 https://github.com/roughike/wavy-image-mask/blob/master/lib/wavy_header_image.dart
************************************************************************************************************************
     * *            *
  *        *      *
*             * *
class CustomShapeClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    final Path path = Path();
      path.lineTo(0.0, size.height-20);
     var firstEndPoint = Offset(size.width*.5, size.height-35.0);
     var  firstControlpoint = Offset(size.width*0.25, size.height-50.0);
      path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy, firstEndPoint.dx,firstEndPoint.dy);
      var secondEndpoint = Offset(size.width, size.height-80.0);
      var secondControlPoint =  Offset(size.width *.75, size.height-10);
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndpoint.dx,secondEndpoint.dy);
      path.lineTo(size.width,0.0);
       
   
    path.close();
    return path;

  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
} 
************************************************************************************************************************
                                    *
                                *
                            *
                       *
                  *
            *      
       *
 *
 import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height - 110);
    var secondEndpoint = Offset(size.width, size.height - 30.0);
    var secondControlPoint = Offset(size.width * .50, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CustomShapeClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height - 105);
    var secondEndpoint = Offset(size.width, size.height - 40.0);
    var secondControlPoint = Offset(size.width * .50, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
 ***************************************************************************************************
 //You can customize this clipper depend your requirement enjoy!!
  
  class InstaClipper2 extends CustomClipper<Path> {
   int a ,b;

 InstaClipper2({this.a,this.b});


  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height - a);

    path.quadraticBezierTo(size.width - (size.width / 4), size.height - 30,
        size.width * 5, size.height - a);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
//You can use above class like below
ClipPath(
          clipper: InstaClipper2(a: 190,b: 110),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xfff93B5B3),
            ),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          ),
        ),
        ClipPath(
          clipper: InstaClipper2(a: 400,b: 200),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xfffC8DAD3),
            ),
            height: MediaQuery.of(context).size.height / 1.1,
            width: double.infinity,
          ),
        ),
        Positioned(
          right: 0,
          child: ClipPath(
            clipper: InstaClipper2(a: 900,b: 200),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffF2F6F5),
              ),
              height: MediaQuery.of(context).size.height/1 ,
              width: MediaQuery.of(context).size.width / 1.3,
            ),
          ),
****************************************************************************************************************
 *      *
 *      *
  *    *
    * *     
 class _MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(0, size.height * 0.8);
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

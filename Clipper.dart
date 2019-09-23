https://iirokrankka.com/2017/09/04/clipping-widgets-with-bezier-curves-in-flutter/
 
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
 
  
  
 

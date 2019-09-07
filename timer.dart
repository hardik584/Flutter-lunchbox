 import 'dart:async';
import 'dart:html';
 
   Timer _timer;
  Color a = RandomColor().randomColor();
  Color b = RandomColor().randomColor();
  Color c = RandomColor().randomColor();
  Color d = RandomColor().randomColor();
  @override
  void initState() {
    super.initState();
    changeColor();
  }

  Future<void> changeColor() async {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (f) {
      setState(() {
        a = RandomColor().randomColor();
        b = RandomColor().randomColor();
        c = RandomColor().randomColor();
        d = RandomColor().randomColor();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
 void responceSuccess(String responce)
 {
   print("reequest was successfully");
   print(responce);
 }


 void responceError(String error)
 {
   print("reequest was not successfully");
   print(error);
 }
void abc()
{
  print("main function done");
}
void main() async
{ 
   await abc();
  await HttpRequest.getString('https://rebounce.online/api/time').then(responceSuccess).catchError(responceError);
   String ui = '655';
  
}

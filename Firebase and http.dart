   
   //for http
   await http.get("https://reqres.in/api/users?page=1").then((onValue) {
   var data = jsonEncode(onvalue.body);
   });
   
   //for Firebase
  final messageReference =
      FirebaseDatabase.instance.reference().child('message_master');

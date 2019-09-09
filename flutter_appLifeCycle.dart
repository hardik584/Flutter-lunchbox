
class Tempo extends StatefulWidget {
  Tempo({Key key}) : super(key: key);

  _TempoState createState() => _TempoState();

}

class _TempoState extends State<Tempo> with WidgetsBindingObserver{
String aes ='1';
  @override
  void dispose() {
    super.dispose();
    print('4 dispose');
    WidgetsBinding.instance.removeObserver(this); 
  }

  @override
  void deactivate() {
    super.deactivate();
    print('*6 deactivate');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('*7 didChangeDependencies');
  }
  @override
void didChangeAppLifecycleState(AppLifecycleState state) {
  super.didChangeAppLifecycleState(state);  if (state == AppLifecycleState.paused) {
    print('outside *11');
  }
  if (state == AppLifecycleState.resumed) {
    print('inside *12');
  }
   if (state == AppLifecycleState.inactive) {
    print('inactive *13');
  }
   if (state == AppLifecycleState.suspending) {
    print('suspending *14');
  }
}

  @override
  void didUpdateWidget(Tempo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('*8 didUpdateWidget');
  }
  
  @override
  void initState() {
  
    super.initState();
    print('1 init');
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  Widget build(BuildContext context) {
    print('3 build');
    return Scaffold(
       body: Column(
         children: <Widget>[
           Text(aes),
           RaisedButton(
             onPressed: (){
               setState(() {
                 print('*9 setstat');
                aes = '0'; 
                 print('*10 setstat');
               });
           
             },
           ),
             RaisedButton(
            child: Text('data'),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Third()));
            },
          ),
         ],
       )
    );
  }
}

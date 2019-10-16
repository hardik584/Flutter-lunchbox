// declare variable.

 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
 
 
   @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS =  IOSInitializationSettings();
    var initSetting = InitializationSettings(android,initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initSetting,onSelectNotification: onselctionNotification,);
  }
  
  // make a function.
  
  Future onselctionNotification(String payload){
    showDialog(context: context,builder: (_) => AlertDialog(
      title:  Text("payload"),
    ));
  }
  
  // create another function for button click event to get Notification
  
    showNotification()async{
    var android = AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android, ios);
    await flutterLocalNotificationsPlugin.show(0, 'title', 'body', platform);
  }
  
  // add dependencies to Android Manifest file.
  
  <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
  
  // for Vibrate.
  
 <uses-permission android:name="android.permission.VIBRATE" />

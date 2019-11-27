SystemChannels.platform.invokeMethod('SystemNavigator.pop');

WillPopScope(
        onWillPop: (){
SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
              child: AlertDialog(
          title: Text("No internet connection!"),
          
          actions: <Widget>[
           
            OutlineButton(
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Text("Cancel",style: TextStyle(color: Colors.red),),
            ),
             OutlineButton(
              onPressed: () {
                Navigator.pop(context);
                getDataLoad();
              },
              child: Text("Retry"),
            ),
          ],
          content: Text("Please try again later"),
        ),
      ),

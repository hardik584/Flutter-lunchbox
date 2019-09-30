//https://github.com/shiburagi/Drawer-Behavior-Flutter 
if (_scaffoldKey.currentState.isDrawerOpen)
                _scaffoldKey.currentState.openEndDrawer();
              else {
                _scaffoldKey.currentState.openDrawer();
              }


final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

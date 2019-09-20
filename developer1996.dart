  int a = 0
 bottomNavigationBar: BottomAppBar(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              color: Color.fromRGBO(197, 214, 226, 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 5,
                    width: double.infinity,
                    color: Color.fromRGBO(96, 163, 209, 1.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: FractionalOffset.center,
                        child: new Row(
                          //mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                  icon: ImageIcon(AssetImage("images/cal.png",) ,size: 30,),                                // icon: Icon(
                                //   CustomIcon.calendar_inv,
                                //   size: 35,
                                // ),
                                disabledColor: Color.fromRGBO(32, 127, 195, 1),
                                color: Colors.white,
                                onPressed: a == 0
                                    ? null
                                    : () => setState(() {
                                          a = 0;
                                          
                                        })),
                            IconButton(
                                icon:  ImageIcon(AssetImage("images/edit.png",) ,size: 30,),
                                disabledColor: Color.fromRGBO(32, 127, 195, 1),
                                color: Colors.white,
                                onPressed: a == 1
                                    ? null
                                    : () => setState(() => a = 1)),
                            IconButton(
                                icon:   ImageIcon(AssetImage("images/notify.png",) ,size: 30,),
                                disabledColor: Color.fromRGBO(32, 127, 195, 1),
                                color: Colors.white,
                                onPressed: a == 2
                                    ? null
                                    : () => setState(() {
                                          a = 2;
                               
                                        })),
                            IconButton(
                                icon:   ImageIcon(AssetImage("images/profile1.png",) ,size: 30,),      
                                disabledColor: Color.fromRGBO(32, 127, 195, 1),
                                color: Colors.white,
                                onPressed: a == 3
                                    ? null
                                    : () => setState(() {
                                          a = 3;
                                           
                                        })),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))

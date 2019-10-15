import 'package:firebase1/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final userDatabase =
    FirebaseDatabase.instance.reference().child("product_master");

class LazyLoad extends StatefulWidget {
  LazyLoad({Key key}) : super(key: key);

  _LazyLoadState createState() => _LazyLoadState();
}

class _LazyLoadState extends State<LazyLoad> {
  int present = 0;
  int perPage = 10;
  List<Posts> userList = List<Posts>();
  List<Posts> items = List<Posts>();

  @override
  void initState() {
    super.initState();

    userDatabase.once().then((DataSnapshot snapShot) {
      if (snapShot.value != null) {
        Map<dynamic, dynamic> g = snapShot.value;
        for (dynamic k in g.keys) {
          userList.add(Posts.fromJson(g[k], key: k)); 
        }
        setState(() {
          items.addAll(userList.getRange(present, present + perPage));
          present = present + perPage;
        });

        print(items.length);
        print(userList.length);
      }
    });
  }

  Future getuser() async {}

  void loadMore() {
    setState(() {
      if ((present + perPage) > userList.length) {
        items.addAll(userList.getRange(present, userList.length));
      } else {
        items.addAll(userList.getRange(present, present + perPage));
      }
      present = present + perPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Lazy Load'),
      ),
      body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              if (items.length != userList.length) {
                loadMore();
              }
            }
          },
          child: items.isNotEmpty
              ? ListView.builder(
                  itemCount: (present <= userList.length)
                      ? items.length + 1
                      : items.length,
                  itemBuilder: (context, index) {
                    return (index == items.length)
                        ? 
                        Container(
                          color: Colors.greenAccent,
                          child: FlatButton(
                            child: Text("Load Mchhore"),
                            onPressed: items.length != userList.length ?() {
                              loadMore();
                            }:null
                          ),
                        )
                        : 
                                                                ListTile(
                                title: Text(items[index].title),
                              ),
                              // (index == items.length ) ? Offstage() :CircularProgressIndicator(),
                  },
                )
              : Offstage()),
    );
  }
}

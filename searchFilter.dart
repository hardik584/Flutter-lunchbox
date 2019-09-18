import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multiprojects2/apiapp/databasehelper.dart';
import 'package:multiprojects2/apiapp/second.dart';

import 'model/earthquack.dart';
import 'model/example.dart';


class ApiProject extends StatefulWidget {
  ApiProject({Key key}) : super(key: key);

  _ApiProjectState createState() => _ApiProjectState();
}

class _ApiProjectState extends State<ApiProject> with WidgetsBindingObserver{
  TextEditingController searchtext = TextEditingController();
  List<Example> ex = List();
  DatabaseHelper db = DatabaseHelper.instance;
  List<Example> responseJson = List();
  List<EarthQuack> earthrespo = List();
  EarthQuack abc = EarthQuack();
  List<Feature> sublist = List();
  List<Feature> abcdf;
  Timer t1;
  bool show = true;
  @override
  void initState() {
    super.initState();
    // getdata();  
    print('3333333333');
    getearthquack();
  
  }





  Future getdata() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/users');
//         await http.get('http://192.168.1.16:3000/user');

// print(response.body);
    if (response.statusCode == 200) {
      responseJson = exampleFromJson(response.body);
      for (int i = 0; i < responseJson.length; i++) {
        // db.insert(responseJson[i].toJson()).then((onValue){
        //   print(onValue);
        //   ex.add(value)
        // });
      }
    } else {}
  }

  Future getearthquack() async {
    final response = await http.get(
        'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02');

    if (response.statusCode == 200) {
      abc = earthQuackFromJson(response.body);
      // final earthQuack = earthQuackFromJson(response.body);
    //  print(abc);
      setState(() {
        abcdf = abc.features;
      });
    //  print(abc.features[9].properties.place);
      // print(abc.features[9].);

      for (int i = 0; i < abcdf.length; i++) {
      //  print(abcdf[i].properties.place);
        //  print(abcdf[i].);
        // db.insert(responseJson[i].toJson()).then((onValue){
        //   print(onValue);
        //   ex.add(value)
        // });
      }
    } else {}
  }

  void push() async {
    await db.read().then((onValue) {
      // print(onValue);
      print(onValue);
      ex = onValue.map((f) => Example.fromJson(f)).toList();
    });
   // print(ex.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Api Project'),
        ),
        body: abcdf != null
            ? Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: searchtext,
                      
                        onTap: (){

                        },
                        onChanged: (text) {
                         // print(text);
                         setState(() {
                            sublist = abcdf
                              .where((place) => place.properties.place
                                  .toLowerCase()
                                  .contains(searchtext.text.toLowerCase()))
                              .toList();
                         });
                         
                         // print(sublist.length);
                          for (int i = 0; i < sublist.length; i++) {
                            print(sublist[i].properties.place);
                          }
                         // print(sublist[1].properties.place);
                        },
                      ),
                    ),
                    searchtext.text.isEmpty ?  Expanded(
                      child: CupertinoScrollbar(
                        child: ListView.builder(
                          
                          itemCount: abcdf.length,
                          itemBuilder: (context, index) {
                            
                            return SizedBox(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(abcdf[index].properties.place),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(abcdf[index].properties.detail),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(abcdf[index]
                                          .properties
                                          .status
                                          .toString()),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(abcdf[index]
                                          .properties
                                          .magType
                                          .toString()),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(abcdf[index]
                                          .properties
                                          .net
                                          .toString()),
                                      Text(abcdf[index]
                                          .geometry
                                          .coordinates
                                          .toString()),
                                      Text(abcdf[index].properties.title)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ):
                    sublist != null ? Expanded(
                      child: CupertinoScrollbar(
                        child: ListView.builder(
                          itemCount: sublist.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(sublist[index].properties.place),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(sublist[index].properties.detail),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(sublist[index]
                                          .properties
                                          .status
                                          .toString()),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(sublist[index]
                                          .properties
                                          .magType
                                          .toString()),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(sublist[index]
                                          .properties
                                          .net
                                          .toString()),
                                      Text(sublist[index]
                                          .geometry
                                          .coordinates
                                          .toString()),
                                      Text(sublist[index].properties.title)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ): Offstage()
                    // RaisedButton(
                    //   onPressed: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondPage()));
                    //   },
                    // ),
                  ],
                ),
              )
            : Offstage()
        );
  }
}

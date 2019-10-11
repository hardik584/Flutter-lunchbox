import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:infilon_user/models/language_master_vo.dart';
import 'package:infilon_user/models/project_master_vo.dart';
import 'package:infilon_user/util/app_color.dart';

import 'package:infilon_user/util/app_image.dart';
import 'package:infilon_user/util/app_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key key}) : super(key: key);

  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  String projectUserId;
  Future<List<Map<String, List>>> projectLangaugeData;
  final projectReference =
      FirebaseDatabase.instance.reference().child('project_master');
  final languageReference =
      FirebaseDatabase.instance.reference().child('language_master');
  AppStyle appStyle = AppStyle();
  getUserId() async {}

  @override
  void initState() {
    super.initState();
    getUserId();
    projectLangaugeData = getProjectLanguageData();
  }

  Future<List<Map<String, List>>> getProjectLanguageData() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    if (projectUserId == null) {
      projectUserId = pre.getString("userId");
    }
    List<ProjectMasterVo> projectData = [];
    List<LanguageMasterVo> languageData = [];
    return await projectReference
        .orderByChild("projectUserId")
        .equalTo(projectUserId)
        .once()
        .then((onValue) async {
      Map<dynamic, dynamic> map = onValue.value;
      if (map != null) {
        for (var key in map.keys) {
          ProjectMasterVo pmv = ProjectMasterVo.fromJson(map[key], key: key);

          languageReference.child(pmv.projectLanguageId).once().then((onValue) {
            LanguageMasterVo lmv =
                LanguageMasterVo.fromJson(onValue.value, key: onValue.key);

            projectData.add(pmv);
            languageData.add(lmv);
            setState(() {});
          });
        }
      }
      return [
        {"projectData": projectData},
        {"languageData": languageData}
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserId();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return getProjectBody(width, height);
  }

  Widget getProjectBody(double width, double height) {
    return FutureBuilder<List<Map<String, List>>>(
        future: projectLangaugeData.then((onValue) async => onValue),
        builder: (context, AsyncSnapshot<List<Map<String, List>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Container(
                child: Text("Something Went worng!"),
              );
            } else {
              List<ProjectMasterVo> projectData =
                  snapshot.data[0]["projectData"];
              List<LanguageMasterVo> languageData =
                  snapshot.data[1]["languageData"];

              return projectData.isEmpty
                  ? LinearProgressIndicator()
                  : ListView.separated(
                      itemCount: projectData.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.03),
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              projectData[index].projectName,
                              style: appStyle.mediumTextStyle(
                                  color: AppColor.primarySwatch),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  languageData[index].languageName,
                                  style: appStyle.smallTextStyle(),
                                ),
                                ImageIcon(
                                  AssetImage(
                                    AppImage.getImage(
                                        imagename: "doubleright.png"),
                                  ),
                                  size: 12,
                                  color: Colors.grey,
                                )
                              ],
                            )
                          ],
                        );
                      },
                    );
            }
          } else {
            return LinearProgressIndicator();
          }
        });
  }
}
// class FeedListState extends State<FeedList> {
//   // no idea how you named your data class...
//   Future<List<ItemData>> _listFuture;

//   @override
//   void initState() {
//     super.initState();

//     // initial load
//     _listFuture = updateAndGetList();
//   }

//   void refreshList() {
//     // reload
//     setState(() {
//       _listFuture = updateAndGetList();
//     });
//   }

//   Future<List<ItemData>> updateAndGetList() async {
//     await widget.feeds.update();

//     // return the list here
//     return widget.feeds.getList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new FutureBuilder<List<ItemData>>(
//       future: _listFuture,
//       builder: (BuildContext context, AsyncSnapshot<List<ItemData>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return new Center(
//             child: new CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return new Text('Error: ${snapshot.error}');
//         } else {
//           final items = snapshot.data ?? <ItemData>[]; // handle the case that data is null

//           return new Scrollbar(
//             child: new RefreshIndicator(
//               child: ListView.builder(
//                 physics: const AlwaysScrollableScrollPhysics(), //Even if zero elements to update scroll
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   return FeedListItem(items[index]);
//                 },
//               ),
//               onRefresh: refreshList,
//             ),
//           );
//         }
//       },
//     );
//   }
// }

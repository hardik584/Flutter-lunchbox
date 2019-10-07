import 'package:flutter/material.dart';
import 'package:infilon_user/util/app_color.dart';
import 'package:infilon_user/util/app_style.dart';

class TicketDetailPage extends StatefulWidget {
  TicketDetailPage({Key key}) : super(key: key);

  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ticket'),
      ),
      bottomNavigationBar: Container(
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          buttonPadding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            Container(
              width: width / 2.5,
              height: height * 0.07,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: RaisedButton.icon(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {},
                label: Text(
                  "Close",
                  style: appStyle.largeTextStyle(color: Colors.red),
                ),
                color: AppColor.primarySwatch,
              ),
            ),
            Container(
              width: width / 2.5,
              height: height * 0.07,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: RaisedButton.icon(
                icon: Icon(Icons.message, color: Colors.white),
                onPressed: () {},
                label: Text(
                  "Chat",
                  style: appStyle.largeTextStyle(color: Colors.white),
                ),
                color: AppColor.primarySwatch,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.grey)),
            padding: EdgeInsets.all(15),
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 75,
                      child: Text(
                        'Subject',
                        style: appStyle.mediumTextStyle(),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(':'),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                     
                      flex: 2,
                      child: Text(
                        'Update data on support screen',
                        style: appStyle.mediumTextStyle(
                            color: AppColor.primarySwatch),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                        width: 75,
                        child: Text(
                          'Project',
                          style: appStyle.mediumTextStyle(),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(':'),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: Text(
                      'PD soni',
                      style: appStyle.mediumTextStyle(
                          color: AppColor.primarySwatch),
                    )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                        width: 75,
                        child: Text(
                          'Language',
                          style: appStyle.mediumTextStyle(),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(':'),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: Text(
                      'Flutter',
                      style: appStyle.mediumTextStyle(
                          color: AppColor.primarySwatch),
                    )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                        width: 75,
                        child: Text(
                          'Support Type',
                          style: appStyle.mediumTextStyle(),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(':'),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: Text(
                      'Maintenance',
                      style: appStyle.mediumTextStyle(
                          color: AppColor.primarySwatch),
                    )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                        width: 75,
                        child: Text(
                          'Estimated Time',
                          style: appStyle.mediumTextStyle(),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(':'),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: Text(
                      '3 days',
                      style: appStyle.mediumTextStyle(
                          color: AppColor.primarySwatch),
                    )),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

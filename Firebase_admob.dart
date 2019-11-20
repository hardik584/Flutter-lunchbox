home.dart
  
 @override
  Widget build(BuildContext context)
{
  
_bannerAd.isLoaded().then((onValue) {
      if (onValue) {

        // print("object if &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&s ");
        // _bannerAd..show();
      } else {
        print("object else ##########################");
        _bannerAd ??= createBannerAd();
        _bannerAd
          ..load()
          ..show();
      }
    });
  return Scaffold();
}
***************************************************************************************************

import 'dart:async';
import 'dart:io';

import 'package:emi_calculator/screens/detail.dart';
import 'package:emi_calculator/screens/rewards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:emi_calculator/utils/colors.dart';
import 'package:emi_calculator/utils/constants.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static var rewardAD = RewardedVideoAd.instance;
  static bool isRewardADLoaded = false;
  static var type = 'Home';

  _HomePageState createState() => _HomePageState();
}

// BannerAd bannerAd;

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static var _xSmallFontSize = 12.0;

  static var _smallFontSize = 14.5;
  static var _mediumFontSize = 15.8;
  static var _largeFontSize = 19.0;
  static var _xLargeFontSize = 27.5;

  static var _txtIFWidth = 80.0;

  int _seekRateValue = 24;
  int _seekYearValue = 1;

  String _txtRateVal = "24";
  String _txtYearVal = "";

  var txtActual2 = "";
  var txtNet2 = "0";
  var txtRolledOver2 = "";

  int invested;
  int gain;
  int futureValue2;

  int step = 1;
  int max = 180;
  int min = 60;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _basicController;
  TabController _livingController;
  TabController _scienceController;
  TabController _miscController;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    // testDevices: testDevice != null ? <String>[testDevice] : null,

    childDirected: true,
  );

  int _coins = 0;

  // BannerAd createBannerAd() {
  //   return BannerAd(
  //     adUnitId: BannerAd.testAdUnitId,
  //     size: AdSize.banner,
  //     targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("BannerAd event $event");

  //       if (event == MobileAdEvent.failedToLoad) {
  //         Constants.adHeight = 0;
  //         setState(() {});
  //       } else if (event == MobileAdEvent.loaded) {
  //         Constants.adHeight = 50;
  //         setState(() {});
  //       }
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);

    // bannerAd = createBannerAd()..load();
    HomePage.isRewardADLoaded = false;
    HomePage.rewardAD.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          _coins += rewardAmount;
        });

        if (HomePage.type == ('Home')) {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => RewardsPage()));
        } else {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => DetailPage()));
        }
      }

      if (event == RewardedVideoAdEvent.failedToLoad) {
        print('EBENNTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT $event');

        setState(() {
          HomePage.isRewardADLoaded = false;
        });
      }
      if (event == RewardedVideoAdEvent.loaded) {
        print('EBENNTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT $event');

        setState(() {
          HomePage.isRewardADLoaded = true;
        });
      }

      if (event == RewardedVideoAdEvent.closed ||
          event == RewardedVideoAdEvent.completed) {
        print('EBENNTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT $event');
        setState(() {
          HomePage.isRewardADLoaded = false;
        });
      }
    };

    _basicController = TabController(vsync: this, length: 4);

    _livingController = TabController(vsync: this, length: 4);

    _scienceController = TabController(vsync: this, length: 4);

    _miscController = TabController(vsync: this, length: 4);

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: CustomColors.colorPrimaryDark));

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // bannerAd ??= createBannerAd();
    // bannerAd
    //   ..load()
    //   ..show();
    showRewardedAd();
  }

  void showRewardedAd() async {
    try {
      await HomePage.rewardAD.load(
          adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);

      // await HomePage.rewardAD.show();
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void showSnackBar(String content) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(content),
      duration: Duration(milliseconds: 1500),
    ));
  }

  @override
  void dispose() {
    _basicController.dispose();
    _livingController.dispose();
    _scienceController.dispose();
    _miscController.dispose();

    // bannerAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          elevation: 0,
          title: Text(
            Constants.app_name,
            style: TextStyle(color: CustomColors.white),
          ),
          backgroundColor: CustomColors.colorPrimary,
        ),
        drawer: DrawerPage(),
        body: Center(child: Text('Home')),
      ),
    );
  }
}

****************************************************************************************************************
drawer.dart

import 'dart:io';

import 'package:emi_calculator/screens/privacy.dart';
import 'package:emi_calculator/screens/rewards.dart';
import 'package:emi_calculator/screens/terms_conditions.dart';
import 'package:emi_calculator/utils/hexColor.dart';
import 'package:flutter/material.dart';
import 'package:emi_calculator/utils/colors.dart';
import 'package:emi_calculator/utils/constants.dart';
import 'package:emi_calculator/utils/styles.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:package_info/package_info.dart';
import 'package:emi_calculator/screens/home.dart';
import 'package:firebase_admob/firebase_admob.dart';

class DrawerPage extends StatefulWidget {
  final int drawerKey;
  static int currentIndex = -1;
  DrawerPage({this.drawerKey});

  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  String appName, packageName, version, buildNumber;

  var _iSize;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    // testDevices: testDevice != null ? <String>[testDevice] : null,

    childDirected: true,
  );

  @override
  void initState() {
    super.initState();

    print('object');
    // bannerAd?.dispose();
    // _bannerAd = null;

    // showRewardedAd();
  }

  Future<void> showRewardedAd() async {
    try {
      await HomePage.rewardAD
          .load(
              adUnitId: RewardedVideoAd.testAdUnitId,
              targetingInfo: targetingInfo)
          .then((onValue) {
        
      });

      // await HomePage.rewardAD.show();
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  void dispose() {
    // _bannerAd ??= createBannerAd();
    // bannerAd
    //   ..load()
    //   ..show();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _iSize = 25.0;

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });

    return Container(
      width: MediaQuery.of(context).size.width * .775,
      child: customDrawer(),
    );
  }

  _launchMoreApps() async {
    if (Platform.isIOS) {
      const url =
          'https://apps.apple.com/us/developer/pavan-mangukiya/id1367455322?app=itunes&ign-mpt=uo%3D4';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (Platform.isAndroid) {
      const url =
          'https://play.google.com/store/apps/developer?id=Infilon+Technologies+Pvt+Ltd';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Drawer customDrawer() {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    //     stops: [
                    //   0.4,
                    //   0.6,
                    //   0.6,
                    // ],

                    tileMode: TileMode.clamp,
                    colors: [
                  HexColor('FF5C57'),
                  HexColor('FFF08380'),
                  HexColor('FF5C57'),

                  // CustomColors.colorAccent,
                  // CustomColors.centerGradient,
                  // CustomColors.centerGradient,
                  // CustomColors.colorAccent,
                ])),
            height: MediaQuery.of(context).size.height * .25,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/emi_logo.png',
                      width: MediaQuery.of(context).size.height * .16,
                      height: MediaQuery.of(context).size.height * .16,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .04),
                    child: Text(
                      Constants.app_name,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          color: CustomColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: new ListTile(
              dense: true,
              // contentPadding: EdgeInsets.all(1.0),
              title: Row(
                children: <Widget>[
                  new Text(
                    'Your Points :',
                    textScaleFactor: 1.1,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: CustomColors.dark_Gray,
                      fontSize: CustomStyles.drawerFontSize,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  new Text(
                    '50',
                    textScaleFactor: 1.1,
                    style: TextStyle(
                        fontSize: CustomStyles.drawerFontSize,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.colorPrimaryDark),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: CustomColors.colorPrimary,
            height: 1,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: new BoxDecoration(
                color:
                    DrawerPage.currentIndex == 0 ? Colors.grey.shade300 : null),
            child: new ListTile(
                dense: true,
                // contentPadding: EdgeInsets.all(1.0),
                title: new Text(
                  Constants.app_name,
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      fontSize: CustomStyles.drawerFontSize,
                      color: DrawerPage.currentIndex == 0
                          ? CustomColors.colorPrimary
                          : null),
                ),
                leading: new ImageIcon(
                    new AssetImage(
                      'assets/images/calculator.png',
                    ),
                    size: _iSize,
                    color: DrawerPage.currentIndex == 0
                        ? CustomColors.colorPrimary
                        : null),
                onTap: () {
                  DrawerPage.currentIndex = 0;
                  Navigator.of(context).pop();
                }),
          ),
          Container(
            decoration: new BoxDecoration(
                color:
                    DrawerPage.currentIndex == 1 ? Colors.grey.shade300 : null),
            child: new ListTile(
                dense: true,
                // contentPadding: EdgeInsets.all(1.0),
                title: new Text(
                  "Earn Points",
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      fontSize: CustomStyles.drawerFontSize,
                      color: DrawerPage.currentIndex == 1
                          ? CustomColors.colorPrimary
                          : null),
                ),
                leading: new ImageIcon(
                    new AssetImage(
                      'assets/images/earn_credit.png',
                    ),
                    size: _iSize,
                    color: DrawerPage.currentIndex == 1
                        ? CustomColors.colorPrimary
                        : null),
                onTap: () async {
                  DrawerPage.currentIndex = 1;
                  Navigator.of(context).pop();
                  HomePage.type = 'Home';

                  await showRewardedAd();

                  if (HomePage.isRewardADLoaded) {
                    print('is Loaded TRUEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
                    try {
                      // await HomePage.rewardAD.load(
                      //     adUnitId: RewardedVideoAd.testAdUnitId,
                      //     targetingInfo: targetingInfo);

                      await HomePage.rewardAD.show().catchError((e) => {
                            // print(
                            //     'MIRINDAAAAAAAAAAAAAAAAAAAAAAAAAAAa ${e.toString()}')
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RewardsPage()))
                          });
                    } on PlatformException catch (e) {
                      print(e.message);
                    }
                  } else {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => RewardsPage()));
                  }
                }),
          ),
          Container(
            decoration: new BoxDecoration(
                color:
                    DrawerPage.currentIndex == 2 ? Colors.grey.shade300 : null),
            child: new ListTile(
                dense: true,
                // contentPadding: EdgeInsets.all(1.0),
                title: new Text(
                  "More Apps",
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      fontSize: CustomStyles.drawerFontSize,
                      color: DrawerPage.currentIndex == 2
                          ? CustomColors.colorPrimary
                          : null),
                ),
                leading: new ImageIcon(
                    new AssetImage(
                      'assets/images/moreapps.png',
                    ),
                    size: _iSize,
                    color: DrawerPage.currentIndex == 2
                        ? CustomColors.colorPrimary
                        : null),
                onTap: () {
                  DrawerPage.currentIndex = 2;
                  Navigator.of(context).pop();

                  _launchMoreApps();
                }),
          ),
          Container(
            decoration: new BoxDecoration(
                color:
                    DrawerPage.currentIndex == 3 ? Colors.grey.shade300 : null),
            child: new ListTile(
                dense: true,
                // contentPadding: EdgeInsets.all(1.0),
                title: new Text(
                  "Rate Us",
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      fontSize: CustomStyles.drawerFontSize,
                      color: DrawerPage.currentIndex == 3
                          ? CustomColors.colorPrimary
                          : null),
                ),
                leading: new ImageIcon(
                    new AssetImage(
                      'assets/images/rate.png',
                    ),
                    size: _iSize,
                    color: DrawerPage.currentIndex == 3
                        ? CustomColors.colorPrimary
                        : null),
                onTap: () {
                  DrawerPage.currentIndex = 3;

                  Navigator.of(context).pop();
                  // Navigator.of(context).push(new MaterialPageRoute(
                  // builder: (BuildContext context) => ContactScreen(true)));
                }),
          ),
          Container(
            decoration: new BoxDecoration(
                color:
                    DrawerPage.currentIndex == 4 ? Colors.grey.shade300 : null),
            child: new ListTile(
                dense: true,
                // contentPadding: EdgeInsets.all(1.0),
                title: new Text(
                  "Share",
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      fontSize: CustomStyles.drawerFontSize,
                      color: DrawerPage.currentIndex == 4
                          ? CustomColors.colorPrimary
                          : null),
                ),
                leading: new ImageIcon(
                    new AssetImage('assets/images/share.png'),
                    size: _iSize,
                    color: DrawerPage.currentIndex == 4
                        ? CustomColors.colorPrimary
                        : null),
                onTap: () {
                  DrawerPage.currentIndex = 4;
                  Navigator.of(context).pop();

                  if (Platform.isAndroid) {
                    Share.share(
                      'https://play.google.com/store/apps/details?id=$packageName',
                      subject: "All Unit Coverter",
                    );
                  }
                  if (Platform.isIOS) {
                    Share.share(
                      'https://apps.apple.com/us/app/$packageName',
                      subject: "All Unit Coverter",
                    );
                  }
                }),
          ),
          Container(
            decoration: new BoxDecoration(
                color:
                    DrawerPage.currentIndex == 5 ? Colors.grey.shade300 : null),
            child: new ListTile(
                dense: true,
                // contentPadding: EdgeInsets.all(1.0),
                title: new Text(
                  "Privacy Policy",
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      fontSize: CustomStyles.drawerFontSize,
                      color: DrawerPage.currentIndex == 5
                          ? CustomColors.colorPrimary
                          : null),
                ),
                leading: new ImageIcon(
                    new AssetImage('assets/images/policy.png'),
                    size: _iSize,
                    color: DrawerPage.currentIndex == 5
                        ? CustomColors.colorPrimary
                        : null),
                onTap: () {
                  DrawerPage.currentIndex = 5;

                  Navigator.of(context).pop();
                  // Navigator.pushNamed(context, Constants.privacyRoute);
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => PrivacyPage()));
                }),
          ),
          Container(
            decoration: new BoxDecoration(
                color:
                    DrawerPage.currentIndex == 6 ? Colors.grey.shade300 : null),
            child: new ListTile(
                dense: true,
                // contentPadding: EdgeInsets.all(1.0),
                title: new Text(
                  "Terms & Conditions",
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      fontSize: CustomStyles.drawerFontSize,
                      color: DrawerPage.currentIndex == 6
                          ? CustomColors.colorPrimary
                          : null),
                ),
                leading: new ImageIcon(
                    new AssetImage('assets/images/terms.png'),
                    size: _iSize,
                    color: DrawerPage.currentIndex == 6
                        ? CustomColors.colorPrimary
                        : null),
                onTap: () {
                  DrawerPage.currentIndex = 6;
                  Navigator.of(context).pop();
                  // Navigator.pushNamed(
                  //   context,
                  //   Constants.termsRoute,
                  // );
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => TermsPage()));
                }),
          ),
        ],
      ),
    );
  }
}
*******************************************************************************************************

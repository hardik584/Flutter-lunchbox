import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:japaclub/models/profile_model.dart';
import 'package:japaclub/utils/api_call.dart';
import 'package:japaclub/utils/app_api.dart';
import 'package:japaclub/utils/app_color.dart';
import 'package:japaclub/utils/app_constant.dart';
import 'package:japaclub/utils/app_graphql.dart';
import 'package:japaclub/utils/app_image.dart';
import 'package:japaclub/utils/app_style.dart';
import 'package:japaclub/utils/app_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> dropDownMenu = ["1", "2", "3", "4"];

Widget getHeaderWidget(BuildContext context) {
  return Container(
    child: Image.asset(
      AppImage.getImage(imagename: "login/login_top.png"),
    ),
  );
}

Future<bool> checkInternet() async {
  var result = await Connectivity().checkConnectivity();
  bool a;
  if (result == ConnectivityResult.none) {
    a = false;
  } else if (result == ConnectivityResult.wifi ||
      result == ConnectivityResult.mobile) {
    a = true;
  }
  return a;
}

Widget loadingIndicator() {
  return CircularProgressIndicator(
    backgroundColor: Colors.blue,
    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
  );
}

Widget getPromisesAndJapaCard(
    {String title, String value, String title1, String value1}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getPromisesCardColumn(title: title, value: value),
        _getPromisesCardColumn(title: title1, value: value1),
      ],
    ),
  );
}

Widget _getPromisesCardColumn({String title, String value}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppStyle.smallTextStyle(color: AppColor.fontColorDarkBlue),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          value,
          style: AppStyle.mediumTextStyle(color: AppColor.fontColorDarkBlack),
        )
      ],
    ),
  );
}

Widget getAppBarLeadingIcon() {
  return ImageIcon(
    AssetImage(
      AppImage.getImage(imagename: "Profile/ic_menu.png"),
    ),
    color: AppColor.fontColorWhite,
  );
}

Widget getBodyStackTopPart() {
  return Container(
    height: 60,
    width: double.infinity,
    color: AppColor.colorPrimary,
  );
}

Widget getFooterWidget(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Image.asset(
      AppImage.getImage(
        imagename: "login/bottom_img.png",
      ),
      fit: BoxFit.cover,
    ),
  );
}

Widget getTextField(
    {String hintText,
    int length,
    FormFieldValidator<String> validator,
    TextInputType textInputType,
    bool enabled,
    TextEditingController controller,
    Color controllerTextColor,
    int maxLine}) {
  return TextFormField(
    style: AppStyle.mediumTextStyle(
      color: enabled != null ? Colors.grey : AppColor.fontColorDarkBlue,
      weight: FontWeight.w400,
    ),
    enabled: enabled,
    inputFormatters: [
      LengthLimitingTextInputFormatter(length),
    ],
    validator: validator,
    keyboardType: textInputType,
    maxLines: maxLine,
    controller: controller,
    decoration: InputDecoration(
      alignLabelWithHint: true,
      // hintText: hintText,
      labelText: hintText,
      labelStyle: AppStyle.mediumTextStyle(weight: FontWeight.w400),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.3)),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 0.3, color: AppColor.colorPrimary),
      ),
      hintStyle: AppStyle.mediumTextStyle(
        color: AppColor.fontColorDarkBlue,
        weight: FontWeight.w400,
      ),
      errorStyle: AppStyle.mediumTextStyle(
        color: Colors.red,
        weight: FontWeight.w400,
      ),
    ),
  );
}

Widget getTextFieldSizedBox() {
  return SizedBox(
    height: 10,
  );
}

Widget getButtonWidget(
    {String title,
    bool isLoading = false,
    String navigateScreen,
    BuildContext context,
    Color buttonColor,
    Function buttonOnclick}) {
  return IgnorePointer(
    ignoring: isLoading,
    child: MaterialButton(
      height: 50,
      color: buttonColor == null ? AppColor.buttonColor : buttonColor,
      child: Container(
        width: double.infinity,
        child: Center(
          child: isLoading
              ? loadingIndicator()
              : Text(
                  title,
                  style: AppStyle.mediumTextStyle(
                      color: AppColor.fontColorWhite, weight: FontWeight.w500),
                ),
        ),
      ),
      onPressed: buttonOnclick,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

void showLog(String key, String value) {
  print('$key : $value');
}

void showEventRegisterDialog(
    {BuildContext context,
    String dialogTitle,
    Function onTap,
    String dialogTitleImageIcon,
    int eventId,
    String eventName,
    int totalPerson}) {
  var existTotalPerson = totalPerson;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
//    shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10),)) ,
          titlePadding: EdgeInsets.all(0),
          title: getDialogTitle(
              dialogTitleImageIcon: dialogTitleImageIcon,
              dialogTitle: dialogTitle,
              context: context),
          content: StatefulBuilder(builder: (context, StateSetter setState) {
            TextEditingController totalPersonController =
                TextEditingController.fromValue(new TextEditingValue(
                    text: totalPerson.toString(),
                    selection: new TextSelection.collapsed(
                        offset: totalPerson.toString().length)));
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "No. of Persons",
                  style: AppStyle.smallTextStyle(
                    color: AppColor.fontColorDarkBlue,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: TextField(
                        onChanged: (val) {
                          if (val.isEmpty) {
                            totalPerson = 0;
                            setState(() {});
                          } else {
                            totalPerson = int.parse(val);
                            setState(() {});
                          }
                        },
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(7),
                        ],
                        controller: totalPersonController,
                        style: AppStyle.mediumTextStyle(
                          color: AppColor.fontColorDarkBlue,
                          weight: FontWeight.w400,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            fillColor: AppColor.alertDialogTextFieldColor,
                            filled: true),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: AppColor.alertDialogTextFieldColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              InkWell(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    totalPerson = totalPerson + 1;
                                    setState(() {});
                                  },
                                  child: Image.asset(
                                    AppImage.getImage(
                                        imagename: "Promises/ic_add.png"),
                                    height: 25,
                                    width: 25,
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    if (totalPerson > 0) {
                                      totalPerson = totalPerson - 1;
                                      setState(() {});
                                    }
                                  },
                                  child: Image.asset(
                                    AppImage.getImage(
                                        imagename: "Promises/ic_sub.png"),
                                    height: 25,
                                    width: 25,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: getButtonWidget(
                      title: "Submit",
                      buttonOnclick: () async {
                        SharedPreferences pre =
                            await SharedPreferences.getInstance();
                        if (existTotalPerson != totalPerson) {
                          checkInternet().then((onValue) {
                            if (onValue) {
                              var token = pre.getString("token");
                              String readRepositories = registerEvent(
                                  eventId: eventId, totalPerson: totalPerson);

                              doGraphQLMutationAPICall(
                                length: 1,
                                httpURL: graphQl,
                                queryData: readRepositories,
                                token: token,
                              ).then((result) {
                                if (result["status"] == "success") {
                                  pre.setInt("persons", totalPerson);

                                  Navigator.pop(context);
                                  onTap();
                                  showToast(
                                      msg:
                                          "You have booked $totalPerson seat in $eventName");
                                } else {
                                  Navigator.pop(context);
                                  showToast(msg: somethingWentWrong);
                                }
                              });
                            } else {
                              showToast(msg: checkInternetMsg);
                            }
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      context: context),
                )
              ],
            );
          }),
        );
      });
}

void showChantComplete(
    {BuildContext context,
    String dialogTitle,
    String dialogTitleImageIcon,
    int contributionCount,
    Function onOk,
    Function onCancle}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.all(10),
      titlePadding: EdgeInsets.all(0),
      title: getDialogTitle(
          dialogTitleImageIcon: dialogTitleImageIcon,
          dialogTitle: dialogTitle,
          context: context),
      content: StatefulBuilder(
        builder: (context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                AppImage.getImage(
                  imagename: "chant/Saint_image.png",
                ),
                height: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                chantDialogMessage,
                style: AppStyle.smallTextStyle(
                    weight: FontWeight.w400, color: AppColor.fontColorDarkBlue),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: getButtonWidget(
                        context: context,
                        title: "Ok",
                        buttonOnclick: () async {
                          SharedPreferences pre =
                              await SharedPreferences.getInstance();
                          var token = pre.getString("token");
                          var formatter = new DateFormat('yyyy-MM-dd');
                          String readRepositories = updateContribution(
                              contributionCount: contributionCount,
                              date: formatter.format(DateTime.now()));
                          checkInternet().then((onValue) {
                            if (onValue) {
                              doGraphQLMutationAPICall(
                                length: 1,
                                httpURL: graphQl,
                                queryData: readRepositories,
                                token: token,
                              ).then((result) {
                                onOk();
                                Navigator.pop(context);
                              });
                            } else {
                              showToast(msg: checkInternetMsg);
                            }
                          });
                        },
                        buttonColor: AppColor.fontColorDarkBlue,
                      )),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 5,
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: getButtonWidget(
                        context: context,
                        title: "Cancel",
                        buttonOnclick: onCancle,
                        buttonColor: AppColor.colorPrimary,
                      ))
                ],
              )
            ],
          );
        },
      ),
    ),
  );
}

void showLogoutDialog(
    {BuildContext context,
    String dialogTitle,
    String dialogTitleImageIcon,
    Function onYes,
    Function onNo,
    String bodyFirstHeader}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.all(10),
      titlePadding: EdgeInsets.all(0),
      title: getDialogTitle(
          dialogTitleImageIcon: dialogTitleImageIcon,
          dialogTitle: dialogTitle,
          context: context),
      content: StatefulBuilder(builder: (context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              bodyFirstHeader,
              style: AppStyle.smallTextStyle(
                color: AppColor.fontColorDarkBlue,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 6,
                    child: getButtonWidget(
                      context: context,
                      buttonColor: AppColor.fontColorDarkBlue,
                      buttonOnclick: () async {
                        SharedPreferences pre =
                            await SharedPreferences.getInstance();
                            await pre.clear();
                        FirebaseAuth logout = FirebaseAuth.instance;
                        logout.signOut().then((result) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              AppConstant.loginRoute, ModalRoute.withName('/'));
                        }).catchError((error) {
                          print(error);
                        });
                      },
                      title: "Yes",
                    )),
                Expanded(
                  child: SizedBox(
                    width: 5,
                  ),
                  flex: 1,
                ),
                Expanded(
                  flex: 6,
                  child: getButtonWidget(
                    context: context,
                    buttonColor: AppColor.colorPrimary,
                    buttonOnclick: () {
                      Navigator.pop(context);
                    },
                    title: "No",
                  ),
                )
              ],
            )
          ],
        );
      }),
    ),
  );
}

void showDailyJapaDialog({
  BuildContext context,
  String dialogTitle,
  Function onADD,
  Function onSUB,
  String date,
  Function onSubmit,
  String flag,
  String dialogTitleImageIcon,
  String bodyFirstHeader,
  int dialyJapaCount,
}) {
  int japaCount = dialyJapaCount;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          titlePadding: EdgeInsets.all(0),
          title: getDialogTitle(
              dialogTitleImageIcon: dialogTitleImageIcon,
              dialogTitle: dialogTitle,
              context: context),
          content: StatefulBuilder(builder: (context, StateSetter setState) {
            TextEditingController mala = TextEditingController.fromValue(
                new TextEditingValue(
                    text: dialyJapaCount.toString(),
                    selection: new TextSelection.collapsed(
                        offset: dialyJapaCount.toString().length)));
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bodyFirstHeader,
                  style: AppStyle.smallTextStyle(
                    color: AppColor.fontColorDarkBlue,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: TextField(
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(7),
                        ],
                        controller: mala,
                        style: AppStyle.mediumTextStyle(
                          color: AppColor.fontColorDarkBlue,
                          weight: FontWeight.w400,
                        ),
                        onChanged: (a) {
//
                          if (a.isEmpty) {
                            dialyJapaCount = 0;
                            setState(() {});
                          } else {
                            dialyJapaCount = int.parse(a);
                            setState(() {});
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            fillColor: AppColor.alertDialogTextFieldColor,
                            filled: true),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: AppColor.alertDialogTextFieldColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    dialyJapaCount = dialyJapaCount + 1;

                                    setState(() {});
                                  },
                                  child: Image.asset(
                                    AppImage.getImage(
                                        imagename: "Promises/ic_add.png"),
                                    height: 25,
                                    width: 25,
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    if (dialyJapaCount > 0) {
                                      dialyJapaCount = dialyJapaCount - 1;

                                      setState(() {});
                                    }
                                  },
                                  child: Image.asset(
                                    AppImage.getImage(
                                        imagename: "Promises/ic_sub.png"),
                                    height: 25,
                                    width: 25,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: getButtonWidget(
                      title: "Save",
                      buttonOnclick: () async {
                        SharedPreferences pre =
                            await SharedPreferences.getInstance();
                        var token = pre.getString("token");
                        if (japaCount != dialyJapaCount) {
                          checkInternet().then((onValue) {
                            if (onValue) {
                              if (flag == promisesDailyMalaPromise) {
                                String readRepositories = updateProfile(
                                    dailyJapaCount: dialyJapaCount);

                                doGraphQLMutationAPICall(
                                  length: 1,
                                  httpURL: graphQl,
                                  queryData: readRepositories,
                                  token: token,
                                ).then((result) {
                                  if (result["status"] == "success") {
                                    print(result);
                                    ProfileMaster profileMaster =
                                        ProfileMaster.fromJson(json
                                            .decode(pre.getString("profile")));
                                    profileMaster.malaPromise = dialyJapaCount;
                                    pre.setString(
                                        "profile", json.encode(profileMaster));
                                    ///////////////////////////////////////////////////
//                                      pre.setInt("user_mala_promise", dialyJapaCount);
                                    ////////////////////////////////////////////////////
                                  }
                                }).whenComplete(() {
                                  onSubmit();
                                });
                                ProfileMaster profileMaster =
                                    ProfileMaster.fromJson(
                                        json.decode(pre.getString("profile")));
                                profileMaster.malaPromise = dialyJapaCount;
                                pre.setString(
                                    "profile", json.encode(profileMaster));
                                ///////////////////////////////////////////////////
//                                  pre.setInt("user_mala_promise", dialyJapaCount);
                                ////////////////////////////////////////////////////
                              } else if (flag == dashboardDailyMalaPromise) {
                                String readRepositories = updateProfile(
                                    dailyJapaCount: dialyJapaCount);

                                doGraphQLMutationAPICall(
                                  length: 1,
                                  httpURL: graphQl,
                                  queryData: readRepositories,
                                  token: token,
                                ).then((result) {
                                  if (result["status"] == "success") {
                                    print(result);
                                  }
                                }).whenComplete(() {
                                  onSubmit();
                                });
                                ProfileMaster profileMaster =
                                    ProfileMaster.fromJson(
                                        json.decode(pre.getString("profile")));
                                profileMaster.malaPromise = dialyJapaCount;
                                pre.setString(
                                    "profile", json.encode(profileMaster));
                                ///////////////////////////////////////////////////
//                                  pre.setInt("user_mala_promise", dialyJapaCount);
                                /////////////////////////////////////////////////////
                              } else if (flag == dashboardMalaToday ||
                                  flag == dashboardMalaYesterday) {
                                String readRepositories = updateContribution(
                                    contributionCount: dialyJapaCount,
                                    date: date);

                                doGraphQLMutationAPICall(
                                  length: 1,
                                  httpURL: graphQl,
                                  queryData: readRepositories,
                                  token: token,
                                ).then((result) {
                                  onSubmit();
                                }).whenComplete(() {
                                  onSubmit();
                                });
                              } else if (flag == "updateContribution") {
                                String readRepositories = updateContribution(
                                    contributionCount: dialyJapaCount,
                                    date: date);

                                doGraphQLMutationAPICall(
                                  length: 1,
                                  httpURL: graphQl,
                                  queryData: readRepositories,
                                  token: token,
                                ).then((result) {
                                  print(result);
                                }).whenComplete(() {
                                  onSubmit();
                                });
                              }
                              Navigator.pop(context);
                            } else {
                              showToast(msg: checkInternetMsg);
                            }
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      context: context),
                )
              ],
            );
          }),
        );
      });
}

void showJapaDialog(
    {BuildContext context,
    String dialogTitle,
    String dialogTitleImageIcon,
    Function onCamera,
    String flag,
    Function onGallery}) {
  // flutter defined function
  showDialog(
      context: context,
      builder: (context) {
        return showAndroidAlertDialog(
            context: context,
            dialogTitle: dialogTitle,
            flag: flag,
            dialogTitleImageIcon: dialogTitleImageIcon,
            onCamera: () {
              onCamera();
            },
            onGalley: () {
              onGallery();
            });
      });
}

Widget getDialogTitle(
    {String dialogTitle, String dialogTitleImageIcon, BuildContext context}) {
  return Container(
    height: 60,
    padding: EdgeInsets.all(10),
    color: AppColor.colorPrimary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            dialogTitle,
            style: AppStyle.smallTextStyle(color: AppColor.fontColorWhite),
          ),
        ),
        IconButton(
            icon: ImageIcon(
              AssetImage(dialogTitleImageIcon),
              color: AppColor.fontColorWhite,
            ),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    ),
  );
}

Widget showAndroidAlertDialog(
    {BuildContext context,
    String dialogTitle,
    String dialogTitleImageIcon,
    Function onCamera,
    String flag,
    Function onGalley}) {
  return AlertDialog(
    contentPadding: EdgeInsets.all(10),
//    shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10),)) ,
    titlePadding: EdgeInsets.all(0),
    title: getDialogTitle(
        dialogTitleImageIcon: dialogTitleImageIcon,
        dialogTitle: dialogTitle,
        context: context),
    content: StatefulBuilder(builder: (context, StateSetter setState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              title: Text(
                'Camera',
                style:
                    AppStyle.mediumTextStyle(color: AppColor.fontColorDarkBlue),
              ),
              onTap: () {
                onCamera();
                if (flag == AppConstant.profileRoute) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                            content: Container(
                                height: 50,
                                child:
                                    Center(child: CircularProgressIndicator())),
                          ));
                }
              }),
          ListTile(
              title: Text(
                'Gallery',
                style:
                    AppStyle.mediumTextStyle(color: AppColor.fontColorDarkBlue),
              ),
              onTap: () {
                onGalley();
                if (flag == AppConstant.profileRoute) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                            content: Container(
                                height: 50,
                                child:
                                    Center(child: CircularProgressIndicator())),
                          ));
                }
              }),
        ],
      );
    }),
  );
}

Widget getDrawerListTile(
    {String title,
    String imagePath,
    int active,
    BuildContext context,
    Function onTap,
    String navigateScreen}) {
  return ListTile(
    contentPadding: EdgeInsets.all(0),
    onTap: onTap,
    title: Padding(
      padding: EdgeInsets.symmetric(horizontal: active == 0 ? 25 : 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          active != 0
              ? Image.asset(
                  AppImage.getImage(imagename: "menu/menu_active.png"),
                  height: 25,
                  width: 25,
                )
              : Offstage(),
          SizedBox(
            width: 5,
          ),
          Image.asset(
            imagePath,
            height: 25,
            width: 25,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: AppStyle.mediumTextStyle(
              color: active != 0
                  ? AppColor.colorPrimary
                  : AppColor.fontColorLightBlue,
            ),
          )
        ],
      ),
    ),
  );
}

Widget getProfileCardSubList({String title, String value}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppStyle.mediumTextStyle(
              color: AppColor.fontColorDarkBlack, weight: FontWeight.w400),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          value,
          style: AppStyle.mediumTextStyle(color: AppColor.fontColorMediumBlue),
        ),
      ],
    ),
  );
}

Widget getEventListCard(
    {String festival,
    String event,
    String date,
    String imagePath,
    Function onTap,
    String navigateRoute,
    BuildContext context}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 3,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        borderSide: BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  imagePath,
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        festival,
                        style: AppStyle.smallTextStyle(
                          color: AppColor.colorPrimary,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        event,
                        style: AppStyle.mediumTextStyle(
                          color: AppColor.fontColorDarkBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        date,
                        style: AppStyle.smallTextStyle(
                            color: AppColor.fontColorDarkBlue,
                            weight: FontWeight.w400),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget getDashboardCountCard(
    {String imagePath, String title, String value, Function onTap}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: 30,
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: AppStyle.smallTextStyle(
                          color: AppColor.fontColorLightBlue),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      value,
                      style: AppStyle.mediumTextStyle(
                          color: AppColor.fontColorDarkBlack),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

showToast({String msg}) {
  Fluttertoast.showToast(msg: msg);
}

int fixNullInt({int count}) {
  return count == null ? 0 : count;
}

Widget getDashboardVideoChantContiner(
    {BuildContext context,
    IconData iconData,
    String imagePath,
    String title,
    Function onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: MediaQuery.of(context).size.height * 0.10,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imagePath), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(
                iconData,
                color: AppColor.fontColorWhite,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: AppStyle.mediumTextStyle(color: AppColor.fontColorWhite),
              )
            ],
          ),
        )),
  );
}

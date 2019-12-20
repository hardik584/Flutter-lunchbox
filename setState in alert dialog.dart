void showDailyJapaDialog(
    {BuildContext context,
    String dialogTitle,
    Function onADD,
    Function onSUB,
    String dialogTitleImageIcon,
    String bodyFirstHeader,
    String dialyJapaCount}) {
  showDialog(
      context: context,
      builder: (context) {
        return   AlertDialog(
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
                            controller:
                                TextEditingController(text: dialyJapaCount),
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
                                      onTap: (){
                                        dialyJapaCount =
                                            (int.parse(dialyJapaCount) + 1)
                                                .toString();
                                        setState(() {});
                                      },
                                      child: Image.asset(
                                        AppImage.getImage(
                                            imagename: "Promises/ic_add.png"),
                                        height: 25,
                                        width: 25,
                                      )),
                                  GestureDetector(
                                      onTap: (){
                                        dialyJapaCount =
                                            (int.parse(dialyJapaCount) - 1)
                                                .toString();
                                        setState(() {});
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
                          title: "Save", buttonOnclick: () {Navigator.pop(context);}, context: context),
                    )
                  ],
                );
              }
            ),

        );
      });
}

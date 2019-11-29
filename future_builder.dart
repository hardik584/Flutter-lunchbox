 Future<http.Response> _errorFuture() async {
    print(widget.languageKey);
    var netCheck = await Utils.checkinternet();
    if (netCheck) {
      var response = await http.post(BaseApi.plant,
          body: json.encode({"lang": widget.languageKey}));
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(AppConstant.error_msg);
      }
    } else {
      throw Exception('Please check your network connection!');
    }
  }
  
  
  FutureBuilder(
                  future: _errorFuture(),
                  builder: (context, AsyncSnapshot snapshot) {
                    print(snapshot.error);
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Container(
                            height: 250,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  AppImage.getImage(
                                    imagename: "cartoon1.png",
                                  ),
                                  height: 130,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  
                                      snapshot.error.toString().replaceAll("Exception:", ""),
                                  style: AppStyle.mediumTextStyle(),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        var plantData = json.decode(snapshot.data.body);

                        List<PlantVo> plantList = [];
                        if (plantData["status"] == "success") {
                          if (plantData["data"] != null &&
                              plantData["data"].length != 0) {
                            for (int i = 0; i < plantData["data"].length; i++) {
                              plantList
                                  .add(PlantVo.fromJson(plantData["data"][i]));
                            }
                          }
                        }

                        return plantData["status"] == "success"
                            ? (plantList == null || plantList.isEmpty)
                                ? Center(
                                    child: Container(
                                      height: 250,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            AppImage.getImage(
                                              imagename: "cartoon1.png",
                                            ),
                                            height: 130,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            plantData["message"] ??
                                                "Something went wrong!!",
                                            style: AppStyle.mediumTextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    constraints: BoxConstraints.tight(
                                        MediaQuery.of(context).size),
                                    decoration: BoxDecoration(
                                        color: AppColor.colorPrimary,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30))),
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    child: StaggeredGridView.countBuilder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      crossAxisCount: 4,
                                      itemCount: plantList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              Card(
                                        elevation: 0.0,
                                        color: AppColor.colorPrimary,
                                        shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              style: BorderStyle.none),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppConstant.plantDetailRoute,
                                                arguments: {
                                                  "languageKey":
                                                      widget.languageKey,
                                                  "plantKey":
                                                      plantList[index].id
                                                });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.colorPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                
                                                image: NetworkImage(
                                                  plantList[index].img,
                                                  
                                                ),
                                                fit: BoxFit.fill,
                                                colorFilter: ColorFilter.mode(
                                                  Colors.black.withOpacity(0.4),
                                                  BlendMode.srcOver,
                                                ),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                plantList[index].title ?? "",
                                                style: AppStyle.largeTextStyle(
                                                  color: Colors.white,
                                                  fontFamily: widget
                                                              .languageKey ==
                                                          "gu"
                                                      ? AppStyle
                                                          .primaryGuFontFamily
                                                      : widget.languageKey ==
                                                              "hi"
                                                          ? AppStyle
                                                              .primaryHiFontFamily
                                                          : AppStyle
                                                              .primaryFontFamily,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      staggeredTileBuilder: (int index) =>
                                          StaggeredTile.count(
                                              2, index.isEven ? 2.5 : 1.6),
                                      mainAxisSpacing: 4.0,
                                      crossAxisSpacing: 4.0,
                                    ),
                                  )
                            : Center(
                                child: Container(
                                  height: 250,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        AppImage.getImage(
                                          imagename: "cartoon1.png",
                                        ),
                                        height: 130,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        plantData["message"] ??
                                            "Something went wrong!!",
                                        style: AppStyle.mediumTextStyle(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      }
                    } else {
                      return Center(
                        child: Container(
                            height: 250,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator()),
                      );
                    }
                  }),

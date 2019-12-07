 List<PlantVo> plantList2 = [];
AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<PlantVo>> key = new GlobalKey();

  bool loading = true;



  getData() async {
    await http
        .post(BaseApi.plant, body: json.encode({"lang": widget.languageKey}))
        .then((onValue) {
      var plantDat = json.decode(onValue.body);
      for (int i = 0; i < plantDat["data"].length; i++) {
        plantList2.add(PlantVo.fromJson(plantDat["data"][i]));
      }
      print(plantList2[0].title);
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }



   Padding(
                padding: const EdgeInsets.all(20.0),
                child: AutoCompleteTextField<PlantVo>(
                  key: key,
                  clearOnSubmit: true,
                  suggestions: plantList2,
                  style: AppStyle.largeTextStyle(
                      fontFamily: widget.languageKey == "gu"
                          ? AppStyle.primaryGuFontFamily
                          : widget.languageKey == AppStyle.primaryHiFontFamily
                              ? "Pragati"
                              : AppStyle.primaryFontFamily),
                  itemFilter: (item, query) {
                    return item.title
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  },
                  itemSorter: (a, b) {
                    return a.title.compareTo(b.title);
                  },
                  itemBuilder: (context, i) {
                    print(i.id);
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(i.title),
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppConstant.plantDetailRoute,
                                arguments: {
                                  "languageKey": widget.languageKey,
                                  "plantKey": i.id
                                });
                          },
                        ),
                        //  Text(i.title)
                      ],
                    );
                  },
                  decoration: InputDecoration(
                      fillColor: AppColor.colorPrimary.withOpacity(0.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: AppColor.colorPrimary.shade100)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: AppColor.colorPrimary.shade100)),
                      filled: true,
                      hintText: widget.labelKey["L12"][widget.languageKey] ??
                          widget.labelKey["L12"]["en"],
                      // AppLocalizations.of(context).findyourplant,
                      hintStyle: AppStyle.largeTextStyle(
                          color: AppColor.colorPrimary,
                          fontFamily: widget.languageKey == "gu"
                              ? AppStyle.primaryGuFontFamily
                              : widget.languageKey ==
                                      AppStyle.primaryHiFontFamily
                                  ? "Pragati"
                                  : AppStyle.primaryFontFamily),

                      // prefixIcon: Icon(Icons.search,color: AppColor.colorPrimary,),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: AppColor.colorPrimary),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppConstant.plantListRoute,
                              arguments: {
                                "search": searchPlant.text,
                                "languageKey": widget.languageKey,
                                "labelKey": widget.labelKey
                              });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      )),
                ),
              ),

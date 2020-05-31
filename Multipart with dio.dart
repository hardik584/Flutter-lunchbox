 FirebaseUser a =
                                  await FirebaseAuth.instance.currentUser();
                              var token = await a.getIdToken(refresh: true);
                              Dio dio = new Dio();
                              FormData formData = new FormData();
                              formData.fields.add(MapEntry(
                                  "name", nameController.text.toString()));
                              formData.fields.add(MapEntry(
                                  "email", emailController.text.toString()));
                              formData.fields.add(MapEntry(
                                  "mobile", mobileController.text.toString()));
                              formData.fields.add(MapEntry("address",
                                  addressController.text.toString()));
                              formData.fields.add(MapEntry(
                                  "city", cityController.text.toString()));
                              formData.fields.add(MapEntry(
                                  "mala_promise", dailyMalaPromise.toString()));
                              formData.fields.add(MapEntry("reminder_interval",
                                  fixNullInt(count: intervalValue).toString()));

                              if (image != null) {
                                formData.files.add(
                                  MapEntry(
                                    "avatar",
                                    await MultipartFile.fromFile(image.path,
                                        filename:
                                            "demo ${image.path.toString().split(".").last}",
                                        contentType: MediaType("image",
                                            "${image.path.toString().split(".").last}")),
                                  ),
                                );
                              }
                              dio
                                  .post(signUpApi,
                                      data: formData,
                                      options: Options(
                                          method: 'POST',
                                          headers: {
                                            "Authorization":
                                                "Bearer ${token.token}",
                                            Headers.contentTypeHeader:
                                                "multipart/form-data"
                                          },
                                          responseType: ResponseType
                                              .json // or ResponseType.JSON
                                          ))
                                  .then((r) {
                                if (r.statusCode == 200) {
                                  String readRepositories = getProfile;
                                  doGraphQLAPICall(
                                    length: 50,
                                    httpURL: graphQl,
                                    queryData: readRepositories,
                                  ).then((result) {
                                    if (result["status"] == "success") {
                                      print(result.toString());
                                      ProfileMaster profileMaster =
                                          ProfileMaster.fromJson(
                                              result["data"]["getProfile"]);

                                      pre.setString("profile",
                                          json.encode(profileMaster));

                                      showToast(msg: "Successfully logged in");
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppConstant.homeRoute,
                                          ModalRoute.withName("/"));
                                    }
                                  });
                                } else {
                                  isLoading = false;
                                  setState(() {});
                                  print(r);
                                }
                              }).catchError((print) {
                                isLoading = false;
                                setState(() {});
                                print(print);
                              });
***********************************************************************************************************
  // var uri = Uri.parse(productAddApi);
                // var request = http.MultipartRequest('POST', uri)
                //   ..fields[keyName] = 'nweiz@google.com a'
                //   ..fields[keyCategory] = 'nweiz@google.com'
                //   ..fields[keyQuantity] = 'nweiz@google.com'
                //   ..fields[keyUnit] = 'nweiz@google.com'
                //   ..fields[keyPrice] = 'nweiz@google.com'
                //   ..fields[keyDesc] = 'nweiz@google.com'
                //   ..fields[keyStatus] = 'nweiz@google.com'
                //   ..files.add(await http.MultipartFile.fromPath(
                //       keyImage, _productAddUpdatePresenter.image.path,
                //       contentType: new MediaType('image', 'jpeg')));

                // var response = await request.send();
                // print(response.reasonPhrase);
                // response.stream.transform(utf8.decoder).listen((value) {
                //   print(value);
                // });
                // if (response.statusCode == 200) print(response);

                FormData formData = FormData.fromMap({
                  keyName: _productAddUpdatePresenter.productName.text.trim(),
                  keyCategory: _productAddUpdatePresenter.productCategory.value,
                  keyQuantity:
                      _productAddUpdatePresenter.productQuantity.text.trim(),
                  keyUnit: _productAddUpdatePresenter.productUnit.value,
                  keyPrice: _productAddUpdatePresenter.productPrice.text.trim(),
                  keyDesc: _productAddUpdatePresenter.productDesc.text.trim(),
                  keyStatus: _productAddUpdatePresenter.productStatus.value,
                  keyImage: MultipartFile.fromFileSync(
                      _productAddUpdatePresenter.image.path,
                      contentType: new MediaType('image', 'jpeg')
                      )
                });
                Dio()
                    .post(
                      productAddApi,
                      data: formData,
                    )
                    .then((value) => print(value.data));

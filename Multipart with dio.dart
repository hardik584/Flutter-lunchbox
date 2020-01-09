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

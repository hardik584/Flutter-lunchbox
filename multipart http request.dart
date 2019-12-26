Future<bool> callAPIMultipartForResolveQuery(
    APICall apiCall,
    String url,
    String deviceId,
    int empId,
    String queryId,
    String solution,
    File file) async {
  try {
    String connectionStatus = 'Unknown';
    final Connectivity _connectivity = new Connectivity();
    /*Check INTERNET connection*/
    connectionStatus = (await _connectivity.checkConnectivity()).toString()

Future<bool> callAPIMultipartForResolveQuery(
    APICall apiCall,
    String url,
    String deviceId,
    int empId,
    String queryId,
    String solution,
    File file) async {
  try {
    String connectionStatus = 'Unknown';
    final Connectivity _connectivity = new Connectivity();
    /*Check INTERNET connection*/
    connectionStatus = (await _connectivity.checkConnectivity()).toString();
    if (connectionStatus == "ConnectivityResult.mobile" ||
        connectionStatus == "ConnectivityResult.wifi") {
      apiCall.onChangeProgress(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var result;
      String auth = prefs.getString(authorization);

      print("URL : $url");

      print("AUTH_KEY : $auth");

      var uri = Uri.parse(url);

      var request = new http.MultipartRequest("POST", uri);

      if (auth != null) {
        request.headers['Authorization'] = auth;
      }

      request.fields[params_emp_id] = empId.toString();
      request.fields[params_device_id] = deviceId;
      request.fields[params_query_id]=queryId;
      request.fields[params_solution]=solution;


      if (file == null) {
        request.fields[params_attachment_file] = "";
      } else {
        var streamPhoto = new http.ByteStream(
            DelegatingStream.typed(file.openRead()));
        var lengthPhoto = await file.length();
        var multipartFile = new http.MultipartFile(
            'attachment_file', streamPhoto, lengthPhoto,
            filename: basename(file.path));
        //contentType: new MediaType('image', 'png'));
        request.files.add(multipartFile);
      }
      final response = await request.send();
      //print(response);
      response.stream.transform(utf8.decoder).listen((value) async {
        result = json.decode(value);

        int code = result['code'];
        String msg = result['msg'];
        print(result);
        if (code == 200) {
          apiCall.onChangeProgress(false);
          apiCall.onSuccess(result);
        } else {
          apiCall.onChangeProgress(false);
          //  showToast(msg);
          if (code == 201) {
            apiCall.onError(msg);
          } else if (code == 202) {
            apiCall.onError(msg);
          } else if (code == 400) {
            apiCall.onError(msg);
          } else if (code == 401) {
            apiCall.onError(msg);
          } else if (code == 403) {
            apiCall.onError(msg);
          } else if (code == 404) {
            apiCall.onError(msg);
          } else if (code == 601) {
            List list = result['error_msg'];
            String message = list.join("|");
            apiCall.onError(message);
          } else {
            apiCall.onError(msg);
            //code = 500 or other than above
          }
        }
      });
      return true;
    } else {
      //showToast("No INTERNET connection.");
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

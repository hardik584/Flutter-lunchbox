 Future<File> _downloadFile(String url, String filename) async {
    http.Client client = new http.Client();
    var req = await client.get(Uri.parse(url));
    var bytes = req.bodyBytes;

    String dir = (await getExternalStorageDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes).then((onValue) {
      // progressString = onValue
      if (file.path.isEmpty) {
        print('make sure the apk file is set');
        return;
      }
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
      if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
        InstallPlugin.installApk(
                file.path, 'com.botanical.botanical_garden_gandhinagar')
            .then((result) {
          print('install apk $result');
        }).catchError((error) {
          print('install apk error: $error');
        });
      } else {
        print('Permission request fail!');
      }
    });
 
   
    
    return file;
  }

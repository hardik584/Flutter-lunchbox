import 'dart:convert';
void main()
{
  var rawJson = '{"url":"http://blah.jpg","id":1}';
  print(rawJson);
  print(rawJson.runtimeType);
  Map<String,dynamic> parsedJson   = json.decode(rawJson);
  print(parsedJson.runtimeType);
  print(parsedJson['id']);
  var imageModel = ImageModel(id: parsedJson['id'],url: parsedJson['url']);
  print(imageModel.id);
  print(imageModel.url);
}
class ImageModel
{
  int id;
  String url;
  ImageModel({this.id,this.url});
}
*****************************************************************************************************************************\
  Future Builder
  FutureBuilder(
              future: http.get("http://192.168.1.16:3000/userMsg"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Container(
                      child: Text("Something Went worng!"),
                    );
                  } else {
                    http.Response abcf = snapshot.data;
                    var po = json.decode(abcf.body);
                    return Container(
                      child: Text(po["message"]),
                    );
                  }
                } else {
                  return LinearProgressIndicator();
                }
              },
            ),

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

  RaisedButton(
     onPressed: () async {
     List<int> imageBytes = await sampleImage.readAsBytes();
     base64Image =  base64Encode(imageBytes);
     print(base64Image);
},
 ),
 SizedBox(height: 30,),
 Image.memory(base64Decode(base64Image)),
            

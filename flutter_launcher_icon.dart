First of all you have to import flutter_launcher_icon library in your pubspec.yaml file
and then 
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_launcher_icons: ^0.7.4
flutter_icons:
  image_path: "assets/images/icon.png"
  android: true 
  ios: true
  
 and run this command 
 flutter pub pub run flutter_launcher_icons:main

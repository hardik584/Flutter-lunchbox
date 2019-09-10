//If we wanna stop split mode then we should put this in android manifest file
android:resizeableActivity="false"
 
 //pubspec.yaml
firebase_core: 
  firebase_database:
  firebase_auth:
  firebase_storage:
firebase_messaging

//build.gradle :-

  classpath 'com.android.tools.build:gradle:3.3.0'
        classpath 'com.google.gms:google-services:4.2.0'


//gradle properties :-

android.enableJetifier=true
android.useAndroidX=true

//build.gradle in app folder.


dependencies {
     testImplementation 'junit:junit:4.12'
    androidTestImplementation 'androidx.test:runner:1.1.1'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.1.1'
    implementation 'com.google.firebase:firebase-core:16.0.9'
    implementation 'com.android.support:appcompat-v7:28.0.0'
    androidTestImplementation "com.android.support:support-annotations:28.0.0"
}
apply plugin: 'com.google.gms.google-services'

 
 // Status Bar hide
 
  @override
  void initState() { 
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

// Status Bar Show

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  }
  

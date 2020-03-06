*****************************************************************
Make file of proguard-rules.pro inside android/app
#Flutter Wrapper
 -keep class io.flutter.app.** { *; }
 -keep class io.flutter.plugin.** { *; }
 -keep class io.flutter.util.** { *; }
 -keep class io.flutter.view.** { *; }
 -keep class io.flutter.** { *; }
 -keep class io.flutter.plugins.** { *; }
 -keep class com.google.firebase.** { *; }
 -dontwarn io.flutter.embedding.**
 -keep class com.dexterous.** { *; }
 -keep class com.transistorsoft.** { *; }
 -keep class com.crashlytics.** { *; }
 -keep class xyz.luan.** { *; }
 -keep class wakelock.** { *; }
 -keep class dexiumtech.phonestatei.** { *; }
 -keep class com.baseflow.** { *; }
 -keep class com.crazecoder.** { *; }
 -keep class io.github.ponnamkarthik.** { *; }
 -keep class de.esys.** { *; }
 -dontwarn com.crashlytics.**
 -ignorewarnings  
 **********************************************************
 In build.gradle
  buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.

            signingConfig signingConfigs.release
            minifyEnabled true
            useProguard true
            shrinkResources true

            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }

    }

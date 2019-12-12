Step 1:

keytool -genkey -v -keystore ~/gmpbkey.jks -keyalg RSA -keysize 2048 -validity 10000 -alias gmpb
//Please set your .key file name instand of gmpbkey.jks and alias name instand of gmpb respectivily
//morever you have to follow all kind o f instruction provide in command promte

Step 2:
Make a key.properties file inside android/ folder
like below as per your keystore file 

storePassword=flutter
keyPassword=flutter
keyAlias=gmpb
storeFile=/Volumes/80/Work/gmpb/gmpbkey.jks

Step 3:

Inside app/build.gradle
paste below
//apply plugin: 'com.android.application'
//apply plugin: 'kotlin-android'
//apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

def keystorePropertiesFile = rootProject.file("key.properties")
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))

Step 4 
Inside app/build.gradle
paste below 
//defaultConfig{}
signingConfigs{
        release{
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    
 Step 5 
 change debug replace with release
 change  buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.release
        }
        
Step 6
Enjoy your app and put on playstore

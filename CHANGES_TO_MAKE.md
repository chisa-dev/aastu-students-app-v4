copy release-keystore.jks to android/app and root 
paste this to app/build.gradle
```gradle
    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            // signingConfig signingConfigs.debug

            signingConfig signingConfigs.release
            minifyEnabled true // Enable R8 code shrinker
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
```

create key.properties in android folder and paste this
```properties
storePassword=YourPassword@2026
keyPassword=YourPassword@2026
keyAlias=release
storeFile=release-keystore.jks
```

run this command to generate release aab -- no icon shinking
```bash
flutter build appbundle --release 
```
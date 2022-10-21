// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBRH6tt13OWQghjrTLU3d9Aij7tpPwfx04',
    appId: '1:630258600727:web:6386f5897e0955d8518552',
    messagingSenderId: '630258600727',
    projectId: 'yo-class',
    authDomain: 'yo-class.firebaseapp.com',
    storageBucket: 'yo-class.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArYuxvDi5ALjlia9EeXZYR465sfV87uS4',
    appId: '1:630258600727:android:ae5e0a97f59f38f5518552',
    messagingSenderId: '630258600727',
    projectId: 'yo-class',
    storageBucket: 'yo-class.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsgIVPCYbY5sGs2yiw8GOM8Rw5M4SVVVo',
    appId: '1:630258600727:ios:299e68037a25a134518552',
    messagingSenderId: '630258600727',
    projectId: 'yo-class',
    storageBucket: 'yo-class.appspot.com',
    iosClientId: '630258600727-5n3n7h3k0m4lvtafmih9eefjquj45db4.apps.googleusercontent.com',
    iosBundleId: 'com.example.zoomCloneTutorial',
  );
}
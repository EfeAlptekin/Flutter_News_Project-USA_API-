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
        return macos;
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
    apiKey: 'AIzaSyASU8zk5Ovuc7OrbBR-Y9WUM6V7DAVNTHs',
    appId: '1:1067219968886:web:bc721354d841504323d057',
    messagingSenderId: '1067219968886',
    projectId: 'newsapi-80222',
    authDomain: 'newsapi-80222.firebaseapp.com',
    storageBucket: 'newsapi-80222.appspot.com',
    measurementId: 'G-XWNDFT2LTN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAB0_MJUnq2PIuvArv2GzBA3IwKCjUoG0E',
    appId: '1:1067219968886:android:49d71aa476aba83723d057',
    messagingSenderId: '1067219968886',
    projectId: 'newsapi-80222',
    storageBucket: 'newsapi-80222.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsDfVYQKcpx59m_T-YYlv5_EwGi1mMtq8',
    appId: '1:1067219968886:ios:26f979685754396623d057',
    messagingSenderId: '1067219968886',
    projectId: 'newsapi-80222',
    storageBucket: 'newsapi-80222.appspot.com',
    iosBundleId: 'com.example.food',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAsDfVYQKcpx59m_T-YYlv5_EwGi1mMtq8',
    appId: '1:1067219968886:ios:a59c15226c0000f323d057',
    messagingSenderId: '1067219968886',
    projectId: 'newsapi-80222',
    storageBucket: 'newsapi-80222.appspot.com',
    iosBundleId: 'com.example.food.RunnerTests',
  );
}

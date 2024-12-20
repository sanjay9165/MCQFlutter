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
    apiKey: 'AIzaSyD1eM-eQagwsnEnuSMcxPlzgAa-akXXomY',
    appId: '1:43267399587:web:f369e19c86770a6cae0416',
    messagingSenderId: '43267399587',
    projectId: 'mcq-dev-583b1',
    authDomain: 'mcq-dev-583b1.firebaseapp.com',
    databaseURL: 'https://mcq-dev-583b1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'mcq-dev-583b1.appspot.com',
    measurementId: 'G-YM7B8PX3W7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwBqJ11TTT5ghtNXBydT_5EPnZi-td_kQ',
    appId: '1:43267399587:android:05dba2096e387517ae0416',
    messagingSenderId: '43267399587',
    projectId: 'mcq-dev-583b1',
    databaseURL: 'https://mcq-dev-583b1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'mcq-dev-583b1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9lOwRDxf0Sjc9p7n6wzz_YqxOKHffDv0',
    appId: '1:43267399587:ios:ad397c8fcd0d1360ae0416',
    messagingSenderId: '43267399587',
    projectId: 'mcq-dev-583b1',
    databaseURL: 'https://mcq-dev-583b1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'mcq-dev-583b1.appspot.com',
    iosBundleId: 'com.example.mcqAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD9lOwRDxf0Sjc9p7n6wzz_YqxOKHffDv0',
    appId: '1:43267399587:ios:acf1cbbc49d3f9afae0416',
    messagingSenderId: '43267399587',
    projectId: 'mcq-dev-583b1',
    databaseURL: 'https://mcq-dev-583b1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'mcq-dev-583b1.appspot.com',
    iosBundleId: 'com.example.mcqAdmin.RunnerTests',
  );
}

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
    apiKey: 'AIzaSyBw8AT_oRrbV1CpRe5SfS-ke-1XX7XKSsg',
    appId: '1:654877735054:web:8395def4ee5d3f5870f1df',
    messagingSenderId: '654877735054',
    projectId: 'doandidong-a3982',
    authDomain: 'doandidong-a3982.firebaseapp.com',
    databaseURL: 'https://doandidong-a3982-default-rtdb.firebaseio.com',
    storageBucket: 'doandidong-a3982.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-T_RvdUB-bdoP3UFdkpjFX33ivfBzcv0',
    appId: '1:654877735054:android:e9215c7f265f631e70f1df',
    messagingSenderId: '654877735054',
    projectId: 'doandidong-a3982',
    databaseURL: 'https://doandidong-a3982-default-rtdb.firebaseio.com',
    storageBucket: 'doandidong-a3982.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhtN6KF1iSCOh2_if8hk7npQfE5B_hg38',
    appId: '1:654877735054:ios:f8e988924f9a1db070f1df',
    messagingSenderId: '654877735054',
    projectId: 'doandidong-a3982',
    databaseURL: 'https://doandidong-a3982-default-rtdb.firebaseio.com',
    storageBucket: 'doandidong-a3982.appspot.com',
    iosBundleId: 'com.example.doandidongappthuongmai',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDhtN6KF1iSCOh2_if8hk7npQfE5B_hg38',
    appId: '1:654877735054:ios:fe0adcfbc30f0dd170f1df',
    messagingSenderId: '654877735054',
    projectId: 'doandidong-a3982',
    databaseURL: 'https://doandidong-a3982-default-rtdb.firebaseio.com',
    storageBucket: 'doandidong-a3982.appspot.com',
    iosBundleId: 'com.example.doandidongappthuongmai.RunnerTests',
  );
}

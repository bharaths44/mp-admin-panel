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
    apiKey: 'AIzaSyAOBO93NeOFbBIP9YDnAP3KXVSjTQChaCI',
    appId: '1:873376294563:web:66c5384c976e1938954116',
    messagingSenderId: '873376294563',
    projectId: 'crud-test-4747',
    authDomain: 'crud-test-4747.firebaseapp.com',
    storageBucket: 'crud-test-4747.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAu9bs0ywW0a9mRNDuNYWaKZDS_jhuR6_E',
    appId: '1:873376294563:android:60990faab244e695954116',
    messagingSenderId: '873376294563',
    projectId: 'crud-test-4747',
    storageBucket: 'crud-test-4747.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClhuJK4qrvSscV3a4msYvxG3xVE8gV9c0',
    appId: '1:873376294563:ios:362f86a1ddc7bcfa954116',
    messagingSenderId: '873376294563',
    projectId: 'crud-test-4747',
    storageBucket: 'crud-test-4747.appspot.com',
    iosBundleId: 'com.tester.test3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyClhuJK4qrvSscV3a4msYvxG3xVE8gV9c0',
    appId: '1:873376294563:ios:362f86a1ddc7bcfa954116',
    messagingSenderId: '873376294563',
    projectId: 'crud-test-4747',
    storageBucket: 'crud-test-4747.appspot.com',
    iosBundleId: 'com.tester.test3',
  );
}
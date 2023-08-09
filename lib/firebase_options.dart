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
    apiKey: 'AIzaSyBewMNkYqszbQqBYElXFRTJHwp7YilHP0A',
    appId: '1:431322261600:web:e9dea3ddaccc6b0499fb05',
    messagingSenderId: '431322261600',
    projectId: 'car-buying-ddece',
    authDomain: 'car-buying-ddece.firebaseapp.com',
    storageBucket: 'car-buying-ddece.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAouOx-oonw121aWLqn0NGsjQUVRDEsc-w',
    appId: '1:431322261600:android:cefa936644bf184599fb05',
    messagingSenderId: '431322261600',
    projectId: 'car-buying-ddece',
    storageBucket: 'car-buying-ddece.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRIbbkQz4G4ca34JiFzg7U8hEbICJ2CHM',
    appId: '1:431322261600:ios:4aae90925b533dcf99fb05',
    messagingSenderId: '431322261600',
    projectId: 'car-buying-ddece',
    storageBucket: 'car-buying-ddece.appspot.com',
    iosClientId: '431322261600-d6457b5vab71rpjohi9e9v5jq82jbid4.apps.googleusercontent.com',
    iosBundleId: 'com.example.carBuyingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRIbbkQz4G4ca34JiFzg7U8hEbICJ2CHM',
    appId: '1:431322261600:ios:a941a6f75b470bca99fb05',
    messagingSenderId: '431322261600',
    projectId: 'car-buying-ddece',
    storageBucket: 'car-buying-ddece.appspot.com',
    iosClientId: '431322261600-qr7ackf88eqd1ld22lcec37nv3etutlp.apps.googleusercontent.com',
    iosBundleId: 'com.example.carBuyingApp.RunnerTests',
  );
}
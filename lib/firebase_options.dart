// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
class DefaultFirebaseOptions  {
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
        return windows;
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
    apiKey: 'AIzaSyC2VIgpdEoaHp5SOdWK2sqIubvCj1TqaiE',
    appId: '1:816037582062:web:1b2413a3374a512b168fff',
    messagingSenderId: '816037582062',
    projectId: 'a-healthcare-management-system',
    authDomain: 'a-healthcare-management-system.firebaseapp.com',
    storageBucket: 'a-healthcare-management-system.firebasestorage.app',
    measurementId: 'G-SGBCGSY9Q7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAn4qMIxFYFDN7VqmZihfCAQkr6xl0AeO0',
    appId: '1:816037582062:android:18f7fcb1504abaa0168fff',
    messagingSenderId: '816037582062',
    projectId: 'a-healthcare-management-system',
    storageBucket: 'a-healthcare-management-system.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBn8BWp9WhO2Lw95-KkM9dahSKWNH0kb_A',
    appId: '1:816037582062:ios:070c65ea852e26c3168fff',
    messagingSenderId: '816037582062',
    projectId: 'a-healthcare-management-system',
    storageBucket: 'a-healthcare-management-system.firebasestorage.app',
    iosClientId: '816037582062-hgucvjsl7cetcqn86pt3ai2oaimtorje.apps.googleusercontent.com',
    iosBundleId: 'com.abdoanany.meditech',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBn8BWp9WhO2Lw95-KkM9dahSKWNH0kb_A',
    appId: '1:816037582062:ios:070c65ea852e26c3168fff',
    messagingSenderId: '816037582062',
    projectId: 'a-healthcare-management-system',
    storageBucket: 'a-healthcare-management-system.firebasestorage.app',
    iosClientId: '816037582062-hgucvjsl7cetcqn86pt3ai2oaimtorje.apps.googleusercontent.com',
    iosBundleId: 'com.abdoanany.meditech',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC2VIgpdEoaHp5SOdWK2sqIubvCj1TqaiE',
    appId: '1:816037582062:web:4d1157fe7075aa42168fff',
    messagingSenderId: '816037582062',
    projectId: 'a-healthcare-management-system',
    authDomain: 'a-healthcare-management-system.firebaseapp.com',
    storageBucket: 'a-healthcare-management-system.firebasestorage.app',
    measurementId: 'G-V26BKS3WY4',
  );

}
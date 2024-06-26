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
    apiKey: 'AIzaSyBlgxuYqxkGT3XjvnVJ8RdSERDsbJvigPU',
    appId: '1:864035235119:web:502db47ca541b341e4adda',
    messagingSenderId: '864035235119',
    projectId: 'loginsignup-cc0e2',
    authDomain: 'loginsignup-cc0e2.firebaseapp.com',
    storageBucket: 'loginsignup-cc0e2.appspot.com',
    measurementId: 'G-8Q9T3EVMHQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2nULfr2IrX5GjPqi2YvP8uEvdYJVV8hE',
    appId: '1:864035235119:android:6f80a44933ff19e4e4adda',
    messagingSenderId: '864035235119',
    projectId: 'loginsignup-cc0e2',
    storageBucket: 'loginsignup-cc0e2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6xk9twmWVyRWzp6inWUF_FozfjwPaVoU',
    appId: '1:864035235119:ios:a97e15ff0bd17de3e4adda',
    messagingSenderId: '864035235119',
    projectId: 'loginsignup-cc0e2',
    storageBucket: 'loginsignup-cc0e2.appspot.com',
    iosBundleId: 'com.example.demo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6xk9twmWVyRWzp6inWUF_FozfjwPaVoU',
    appId: '1:864035235119:ios:a97e15ff0bd17de3e4adda',
    messagingSenderId: '864035235119',
    projectId: 'loginsignup-cc0e2',
    storageBucket: 'loginsignup-cc0e2.appspot.com',
    iosBundleId: 'com.example.demo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBlgxuYqxkGT3XjvnVJ8RdSERDsbJvigPU',
    appId: '1:864035235119:web:9f61d88c0ddb13cae4adda',
    messagingSenderId: '864035235119',
    projectId: 'loginsignup-cc0e2',
    authDomain: 'loginsignup-cc0e2.firebaseapp.com',
    storageBucket: 'loginsignup-cc0e2.appspot.com',
    measurementId: 'G-FREEER8JB5',
  );

}
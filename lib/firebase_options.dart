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
    apiKey: 'AIzaSyD7EjK5nWmlulIon9SthwOZaRUHs9cP5_4',
    appId: '1:74625169399:web:0593a8827aa23de897e0f2',
    messagingSenderId: '74625169399',
    projectId: 'todoapp-978c2',
    authDomain: 'todoapp-978c2.firebaseapp.com',
    storageBucket: 'todoapp-978c2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCJNSxRW8iVycVexU_zzZRbwT97LDVxuU',
    appId: '1:74625169399:android:fbe288e11618f00597e0f2',
    messagingSenderId: '74625169399',
    projectId: 'todoapp-978c2',
    storageBucket: 'todoapp-978c2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZlDGjrFFQxwiq1ub7Do-Qyo1h0K46sdM',
    appId: '1:74625169399:ios:9ac28f10d0f4e93597e0f2',
    messagingSenderId: '74625169399',
    projectId: 'todoapp-978c2',
    storageBucket: 'todoapp-978c2.appspot.com',
    iosBundleId: 'com.example.todoTaskApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZlDGjrFFQxwiq1ub7Do-Qyo1h0K46sdM',
    appId: '1:74625169399:ios:9ac28f10d0f4e93597e0f2',
    messagingSenderId: '74625169399',
    projectId: 'todoapp-978c2',
    storageBucket: 'todoapp-978c2.appspot.com',
    iosBundleId: 'com.example.todoTaskApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD7EjK5nWmlulIon9SthwOZaRUHs9cP5_4',
    appId: '1:74625169399:web:e6d50e5561043c3897e0f2',
    messagingSenderId: '74625169399',
    projectId: 'todoapp-978c2',
    authDomain: 'todoapp-978c2.firebaseapp.com',
    storageBucket: 'todoapp-978c2.appspot.com',
  );
}

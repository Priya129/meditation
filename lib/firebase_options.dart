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
    apiKey: 'AIzaSyC15kCybUGfuJ8bE9WBkmveoNgPoBdbYkY',
    appId: '1:975851079272:web:8dc338a2c88fa379611ddd',
    messagingSenderId: '975851079272',
    projectId: 'meditationapp-1da74',
    authDomain: 'meditationapp-1da74.firebaseapp.com',
    storageBucket: 'meditationapp-1da74.appspot.com',
    measurementId: 'G-BRD3C20MW9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMdgPEM-6s53eRDI_AH4NtC7P-FUxEeFI',
    appId: '1:975851079272:android:613bd7d019489488611ddd',
    messagingSenderId: '975851079272',
    projectId: 'meditationapp-1da74',
    storageBucket: 'meditationapp-1da74.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1cCDFkPO84YERiEjuj6K7AL-7vVEjVqw',
    appId: '1:975851079272:ios:44c8a3b6b0edbe5f611ddd',
    messagingSenderId: '975851079272',
    projectId: 'meditationapp-1da74',
    storageBucket: 'meditationapp-1da74.appspot.com',
    iosBundleId: 'com.example.storyapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1cCDFkPO84YERiEjuj6K7AL-7vVEjVqw',
    appId: '1:975851079272:ios:44c8a3b6b0edbe5f611ddd',
    messagingSenderId: '975851079272',
    projectId: 'meditationapp-1da74',
    storageBucket: 'meditationapp-1da74.appspot.com',
    iosBundleId: 'com.example.storyapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC15kCybUGfuJ8bE9WBkmveoNgPoBdbYkY',
    appId: '1:975851079272:web:477443a5a1412308611ddd',
    messagingSenderId: '975851079272',
    projectId: 'meditationapp-1da74',
    authDomain: 'meditationapp-1da74.firebaseapp.com',
    storageBucket: 'meditationapp-1da74.appspot.com',
    measurementId: 'G-67D0W0JRDV',
  );
}

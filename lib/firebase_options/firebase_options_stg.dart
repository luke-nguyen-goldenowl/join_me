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
    apiKey: 'AIzaSyDUEEH8RZBzl1Tj3QOJC1ac1ABfNAbwri0',
    appId: '1:826001615661:web:ac8276a4d9ee9e979d01a4',
    messagingSenderId: '826001615661',
    projectId: 'see-joy-3f334',
    authDomain: 'see-joy-3f334.firebaseapp.com',
    storageBucket: 'see-joy-3f334.appspot.com',
    measurementId: 'G-XG42X9EK4W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_DU2Squ6viX4VdgtwBkkxRugPxysgVM4',
    appId: '1:826001615661:android:e75bc039e6e313c89d01a4',
    messagingSenderId: '826001615661',
    projectId: 'see-joy-3f334',
    storageBucket: 'see-joy-3f334.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBR4OD1fZqmsNT8M86dWhBq6R8NkAM5Y2M',
    appId: '1:826001615661:ios:2c995b826f8bb8279d01a4',
    messagingSenderId: '826001615661',
    projectId: 'see-joy-3f334',
    storageBucket: 'see-joy-3f334.appspot.com',
    iosBundleId: 'com.keith.seejoy.stg',
  );
}

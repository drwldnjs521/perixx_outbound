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
    apiKey: 'AIzaSyB2A_NjG52eC15I2dv4MdXZZ0BQhu7r6NU',
    appId: '1:433585274613:web:76202da144e0f8480dcfbc',
    messagingSenderId: '433585274613',
    projectId: 'perixx-outbound-auth',
    authDomain: 'perixx-outbound-auth.firebaseapp.com',
    storageBucket: 'perixx-outbound-auth.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBE0SEZ-qssXx-QyTIM-pqDKGSDhnpfe0Q',
    appId: '1:433585274613:android:f3393f5333a26fbf0dcfbc',
    messagingSenderId: '433585274613',
    projectId: 'perixx-outbound-auth',
    storageBucket: 'perixx-outbound-auth.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJwQ64JvbeS78zyuasvnkc8Bdc2YwGpm4',
    appId: '1:433585274613:ios:6de0487e54ad7e7e0dcfbc',
    messagingSenderId: '433585274613',
    projectId: 'perixx-outbound-auth',
    storageBucket: 'perixx-outbound-auth.appspot.com',
    iosClientId: '433585274613-sfs2ud3kcd4tua3nr4uovu2mg99b03tl.apps.googleusercontent.com',
    iosBundleId: 'com.perixx.perixxOutbound',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJwQ64JvbeS78zyuasvnkc8Bdc2YwGpm4',
    appId: '1:433585274613:ios:6de0487e54ad7e7e0dcfbc',
    messagingSenderId: '433585274613',
    projectId: 'perixx-outbound-auth',
    storageBucket: 'perixx-outbound-auth.appspot.com',
    iosClientId: '433585274613-sfs2ud3kcd4tua3nr4uovu2mg99b03tl.apps.googleusercontent.com',
    iosBundleId: 'com.perixx.perixxOutbound',
  );
}

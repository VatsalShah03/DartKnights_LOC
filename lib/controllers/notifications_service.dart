import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAgwttdaFV5p1w7Yw1ixzq6pj5XewjAxO0',
    appId: '1:996387500617:web:6e54e0b812af281ee5c598',
    messagingSenderId: '996387500617',
    projectId: 'fcmflutter33',
    authDomain: 'fcmflutter33.firebaseapp.com',
    storageBucket: 'fcmflutter33.appspot.com',
    measurementId: 'G-MVXVCR152B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnu2Jr2jY90Sy2wNbYoDNKULmQiiDZltE',
    appId: '1:996387500617:android:58cd9c56bbccfa11e5c598',
    messagingSenderId: '996387500617',
    projectId: 'fcmflutter33',
    storageBucket: 'fcmflutter33.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0eBwdYSVn-2GzRmSVnGSb8-Cw4Yjte4U',
    appId: '1:996387500617:ios:65a23e716f678d9fe5c598',
    messagingSenderId: '996387500617',
    projectId: 'fcmflutter33',
    storageBucket: 'fcmflutter33.appspot.com',
    iosClientId: '996387500617-lhv02mjd72pptsdmjrgr70doi6ibaksq.apps.googleusercontent.com',
    iosBundleId: 'com.example.fcmflutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB0eBwdYSVn-2GzRmSVnGSb8-Cw4Yjte4U',
    appId: '1:996387500617:ios:65a23e716f678d9fe5c598',
    messagingSenderId: '996387500617',
    projectId: 'fcmflutter33',
    storageBucket: 'fcmflutter33.appspot.com',
    iosClientId: '996387500617-lhv02mjd72pptsdmjrgr70doi6ibaksq.apps.googleusercontent.com',
    iosBundleId: 'com.example.fcmflutter',
  );
}
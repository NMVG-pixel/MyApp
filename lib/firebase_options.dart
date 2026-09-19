import 'package:firebase_core/firebase_core.dart';
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
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions n’est pas configuré pour cette plateforme.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDegGnO-ym7Ugaa0Niyn-hZ2fB0pYyvhk8',
    appId: '1:571977178090:web:5f8bf2000ec0107258f093',
    messagingSenderId: '571977178090',
    projectId: 'doc-admins',
    authDomain: 'doc-admins.firebaseapp.com',
    storageBucket: 'doc-admins.firebasestorage.app',
    measurementId: 'G-VST7WM5HB8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXA4gHoyOaji85CE_QgtdV20JkhCofg1w',
    appId: '1:571977178090:android:b68848352f1d2b5758f093',
    messagingSenderId: '571977178090',
    projectId: 'doc-admins',
    storageBucket: 'doc-admins.firebasestorage.app',
  );
}
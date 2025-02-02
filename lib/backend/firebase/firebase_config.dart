import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "XXXXX",
            authDomain: "XXXXX",
            projectId: "XXXXX",
            storageBucket: "XXXXX",
            messagingSenderId: "XXXXXX",
            appId: "XXXXXXX",
            measurementId: "XXXXXX"));
  } else {
    await Firebase.initializeApp();
  }
}
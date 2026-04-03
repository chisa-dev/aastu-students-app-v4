import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '/environment_values.dart';

Future initFirebase() async {
  if (kIsWeb) {
    final env = FFDevEnvironmentValues();
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: env.firebaseApiKey,
            authDomain: env.firebaseAuthDomain,
            projectId: env.firebaseProjectId,
            storageBucket: env.firebaseStorageBucket,
            messagingSenderId: env.firebaseMessagingSenderId,
            appId: env.firebaseAppId,
            measurementId: env.firebaseMeasurementId));
  } else {
    await Firebase.initializeApp();
  }
}

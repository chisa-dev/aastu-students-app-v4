import 'package:firebase_core/firebase_core.dart';

Future initFirebase() async {
  await Firebase.initializeApp();
}

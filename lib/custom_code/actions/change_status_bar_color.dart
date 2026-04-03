// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

Future changeStatusBarColor(
  BuildContext context,
  Color color,
) async {
  // Add your function code here!
  Brightness iconBrightness =
      ThemeData.estimateBrightnessForColor(color) == Brightness.light
          ? Brightness.dark // Dark icons for light background
          : Brightness.light; // Light icons for dark background

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: color, // Set the status bar color
      statusBarIconBrightness:
          iconBrightness, // Set icon brightness automatically
    ),
  );
}

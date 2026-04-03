// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

Future<String> simpleBarCodeScanner(BuildContext context) async {
  // Add your function code here!

  var res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ));

  if (res is String) {
    return res;
  }
  return "null";
}

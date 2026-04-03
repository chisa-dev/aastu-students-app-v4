// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

Future<String> pasteFromClipboard() async {
  // Add your function code here!
  // Retrieve the data from the clipboard
  ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);

  // Return the text if available; otherwise, return an empty string
  return data?.text ?? '';
}

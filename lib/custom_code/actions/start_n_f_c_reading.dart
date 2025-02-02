// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:nfc_manager/nfc_manager.dart';

Future startNFCReading(BuildContext context) async {
  // Add your function code here!
  try {
    // Check if NFC is available on the device.
    bool isAvailable = await NfcManager.instance.isAvailable();

    // If NFC is available, start an NFC session to listen for NFC tags.
    if (isAvailable) {
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          // Show a SnackBar with the detected tag data.
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text('NFC Tag Detected: ${tag.data}')));

          // Optionally, stop the session after reading.
          NfcManager.instance.stopSession();
        },
      );
    } else {
      // Show a SnackBar if NFC is not available.
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('NFC not available.')));
    }
  } catch (e) {
    // Show a SnackBar for any errors.
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Error reading NFC: $e')));
  }
}

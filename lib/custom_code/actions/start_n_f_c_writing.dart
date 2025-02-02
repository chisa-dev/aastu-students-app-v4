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

Future startNFCWriting(
  BuildContext context,
  String userID,
) async {
  // Add your function code here!
  try {
    // Check if NFC is available on the device.
    bool isAvailable = await NfcManager.instance.isAvailable();

    // If NFC is available, start a session to listen for NFC tags.
    if (isAvailable) {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        try {
          // Create an NDEF message and write it to the tag.
          NdefMessage message = NdefMessage([NdefRecord.createText(userID)]);
          await Ndef.from(tag)?.write(message);

          // Show a SnackBar notification for successful write.
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text('Data emitted successfully')));

          Uint8List payload = message.records.first.payload;
          String text = String.fromCharCodes(payload);

          // Show a SnackBar with written data.
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text('Written data: $text')));

          // Stop the NFC session.
          NfcManager.instance.stopSession();
        } catch (e) {
          // Show a SnackBar for any error during the NFC write process.
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text('Error emitting NFC data: $e')));
          NfcManager.instance
              .stopSession(errorMessage: 'Error emitting NFC data');
        }
      });
    } else {
      // Show a SnackBar if NFC is not available.
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('NFC not available.')));
    }
  } catch (e) {
    // Show a SnackBar for any other errors.
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Error writing to NFC: $e')));
  }
}

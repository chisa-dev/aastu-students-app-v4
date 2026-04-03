// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:simple_barcode_scanner/enum.dart';

Future startNFCReading(BuildContext context) async {
  try {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SimpleBarcodeScannerPage(
          isShowFlashIcon: true,
          scanType: ScanType.qr,
        ),
      ),
    );

    if (res is String && res != '-1' && res != 'null' && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('QR Code Scanned: $res'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error scanning QR code: $e')),
      );
    }
  }
}

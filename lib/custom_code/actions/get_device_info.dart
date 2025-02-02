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

import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

Future<DeviceInfoStruct> getDeviceInfo() async {
  // Add your function code here!

  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String model = '';
  String osVersion = '';
  String appVersion = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    model = androidInfo.model ?? 'Unknown';
    osVersion = androidInfo.version.release ?? 'Unknown';
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    model = iosInfo.utsname.machine ?? 'Unknown';
    osVersion = iosInfo.systemVersion ?? 'Unknown';
  }

  return DeviceInfoStruct(
      appVersion: appVersion,
      model: model,
      osVersion: osVersion,
      buildNumber: buildNumber);
}

import 'dart:convert';
import 'package:flutter/services.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFDevEnvironmentValues {
  static const String currentEnvironment = 'Development';
  static const String environmentValuesPath =
      'assets/environment_values/environment.json';

  static final FFDevEnvironmentValues _instance =
      FFDevEnvironmentValues._internal();

  factory FFDevEnvironmentValues() {
    return _instance;
  }

  FFDevEnvironmentValues._internal();

  Future<void> initialize() async {
    try {
      final String response =
          await rootBundle.loadString(environmentValuesPath);
      final data = await json.decode(response);
      _APIKEY = data['APIKEY'];
      _ClientSecrate = data['ClientSecrate'];
    } catch (e) {
      print('Error loading environment values: $e');
    }
  }

  String _APIKEY = '';
  String get APIKEY => _APIKEY;

  String _ClientSecrate = '';
  String get ClientSecrate => _ClientSecrate;
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

class FFDevEnvironmentValues {
  static const String currentEnvironment = 'Production';

  static final FFDevEnvironmentValues _instance =
      FFDevEnvironmentValues._internal();

  factory FFDevEnvironmentValues() {
    return _instance;
  }

  FFDevEnvironmentValues._internal();

  Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
  }

  String get ClientSecrate => dotenv.env['HORAN_CLIENT_SECRET'] ?? '';

  String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'https://api.horan.et';

  String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';
  String get firebaseAuthDomain => dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';
  String get firebaseProjectId => dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  String get firebaseStorageBucket => dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
  String get firebaseMessagingSenderId => dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  String get firebaseAppId => dotenv.env['FIREBASE_APP_ID'] ?? '';
  String get firebaseMeasurementId => dotenv.env['FIREBASE_MEASUREMENT_ID'] ?? '';

  String get adminEmail => dotenv.env['ADMIN_EMAIL'] ?? '';
  String get emailHost => dotenv.env['EMAIL_HOST'] ?? '';
  String get emailUser => dotenv.env['EMAIL_USER'] ?? '';
  String get emailPass => dotenv.env['EMAIL_PASS'] ?? '';
}

import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io' show Platform;

import '/backend/backend.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Service that handles anonymous user creation and management.
/// When a new user opens the app, they are signed in anonymously and
/// a Firestore user document is created with a generated display name.
class AnonymousUserService {
  static final AnonymousUserService _instance = AnonymousUserService._();
  factory AnonymousUserService() => _instance;
  AnonymousUserService._();

  /// Check if the current Firebase user is anonymous.
  bool get isAnonymous =>
      FirebaseAuth.instance.currentUser?.isAnonymous ?? true;

  /// Check if the current user has a full account (not anonymous).
  bool get hasFullAccount =>
      FirebaseAuth.instance.currentUser != null &&
      !FirebaseAuth.instance.currentUser!.isAnonymous;

  /// Ensures a Firestore user document exists for an already-authenticated user.
  /// Covers the case where Firebase Auth has a user but the Firestore doc is missing.
  Future<void> ensureUserDocumentExists(User user) async {
    try {
      await _createAnonymousUserDocument(user);
    } catch (e) {
      debugPrint('[AnonymousUserService] ensureUserDocumentExists error: $e');
    }
  }

  /// Sign in anonymously and create user document.
  /// Returns the User if successful.
  Future<User?> signInAnonymously() async {
    try {
      final credential = await FirebaseAuth.instance.signInAnonymously();
      final user = credential.user;
      if (user != null) {
        await _createAnonymousUserDocument(user);
      }
      return user;
    } catch (e) {
      debugPrint('[AnonymousUserService] Error signing in anonymously: $e');
      return null;
    }
  }

  /// Creates the Firestore user document for an anonymous user.
  Future<void> _createAnonymousUserDocument(User user) async {
    final userRecord = UsersRecord.collection.doc(user.uid);
    final userExists = await userRecord.get().then((u) => u.exists);
    if (userExists) {
      currentUserDocument = await UsersRecord.getDocumentOnce(userRecord);
      return;
    }

    // Generate a display name
    final displayName = await _generateDisplayName();
    final userName = _generateUsername();

    // Get device info
    final deviceInfo = await _getDeviceInfo();
    final packageInfo = await PackageInfo.fromPlatform();

    final userData = createUsersRecordData(
      uid: user.uid,
      displayName: displayName,
      userName: userName,
      email: '',
      photoUrl: '',
      createdTime: getCurrentTimestamp,
      lastActiveTime: getCurrentTimestamp,
      userType: 'anonymous',
      accountCreatedSource: 'anonymous',
      appVersion: '${packageInfo.version}+${packageInfo.buildNumber}',
      deviceModel: deviceInfo['model'] ?? '',
      osVersion: deviceInfo['osVersion'] ?? '',
      buildNumber: packageInfo.buildNumber,
      deviceInfo: deviceInfo['fullInfo'] ?? '',
      isBlocked: false,
      isAdmin: false,
      isVerified: false,
      hasVirtualId: false,
      engagementScore: 0,
      profileCompletion: 0,
    );

    await userRecord.set(userData);
    currentUserDocument = UsersRecord.getDocumentFromData(userData, userRecord);
  }

  /// Generate a creative display name using Gemini, with fallback.
  Future<String> _generateDisplayName() async {
    try {
      final name = await _generateNameWithGemini();
      if (name.isNotEmpty) return name;
    } catch (e) {
      debugPrint('[AnonymousUserService] Gemini name generation failed: $e');
    }
    return _generateFallbackName();
  }

  /// Use Gemini to generate a fun campus-themed display name.
  Future<String> _generateNameWithGemini() async {
    try {
      final apiKey = await _getGeminiApiKey();
      if (apiKey.isEmpty) return '';

      final model = GenerativeModel(
        model: 'gemini-2.0-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.9,
          responseMimeType: 'application/json',
        ),
      );

      final prompt = '''
Generate ONE creative, fun, and friendly display name for a university student app user.
The name should be related to education, campus life, academy, or student culture.
It should be 2-3 words, catchy, and appropriate. Examples: "Stellar Scholar", "Campus Explorer", "Curious Coder".

Return ONLY a JSON object: {"name": "The Generated Name"}
''';

      final response = await model.generateContent([Content.text(prompt)]);
      final text = response.text;
      if (text != null && text.isNotEmpty) {
        final json = _tryParseJson(text);
        if (json != null && json['name'] is String) {
          final name = json['name'] as String;
          if (name.isNotEmpty && name.length < 30) return name;
        }
      }
    } catch (e) {
      debugPrint('[AnonymousUserService] Gemini error: $e');
    }
    return '';
  }

  /// Get Gemini API key from Firestore.
  Future<String> _getGeminiApiKey() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('app_config')
          .doc('gemini')
          .get();
      if (doc.exists && doc.data() != null) {
        return doc.data()!['api_key'] as String? ?? '';
      }
    } catch (_) {}
    return '';
  }

  Map<String, dynamic>? _tryParseJson(String text) {
    try {
      String cleaned = text;
      if (cleaned.contains('{')) {
        cleaned = cleaned.substring(cleaned.indexOf('{'));
      }
      if (cleaned.contains('}')) {
        cleaned = cleaned.substring(0, cleaned.lastIndexOf('}') + 1);
      }
      return Map<String, dynamic>.from(jsonDecode(cleaned));
    } catch (_) {
      return null;
    }
  }

  /// Generate a fallback name from predefined campus-themed word lists.
  String _generateFallbackName() {
    final random = Random();
    final adjectives = [
      'Stellar', 'Curious', 'Bright', 'Swift', 'Bold',
      'Clever', 'Sharp', 'Keen', 'Noble', 'Wise',
      'Brave', 'Calm', 'Epic', 'Fair', 'Grand',
      'Happy', 'Jolly', 'Lucky', 'Merry', 'Neat',
      'Prime', 'Quick', 'Rare', 'Sure', 'True',
      'Vivid', 'Warm', 'Young', 'Zesty', 'Cool',
    ];
    final nouns = [
      'Scholar', 'Explorer', 'Pioneer', 'Thinker', 'Builder',
      'Learner', 'Dreamer', 'Seeker', 'Achiever', 'Creator',
      'Innovator', 'Mentor', 'Planner', 'Reader', 'Writer',
      'Coder', 'Artist', 'Leader', 'Solver', 'Maker',
      'Phoenix', 'Eagle', 'Falcon', 'Tiger', 'Lion',
      'Spark', 'Star', 'Comet', 'Nova', 'Orbit',
    ];

    final adj = adjectives[random.nextInt(adjectives.length)];
    final noun = nouns[random.nextInt(nouns.length)];
    final number = random.nextInt(99) + 1;
    return '$adj $noun $number';
  }

  /// Generate a unique username (lowercase, no spaces).
  String _generateUsername() {
    final random = Random();
    final prefixes = [
      'campus', 'aastu', 'scholar', 'student', 'uni',
      'edu', 'tech', 'code', 'learn', 'study',
    ];
    final prefix = prefixes[random.nextInt(prefixes.length)];
    final number = random.nextInt(9999) + 1000;
    return '${prefix}_user_$number';
  }

  /// Get device information.
  Future<Map<String, String>> _getDeviceInfo() async {
    if (kIsWeb) {
      return {'model': 'Web', 'osVersion': 'Web', 'fullInfo': 'Web Browser'};
    }
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final info = await deviceInfoPlugin.androidInfo;
        return {
          'model': '${info.brand} ${info.model}',
          'osVersion': 'Android ${info.version.release}',
          'fullInfo':
              '${info.brand} ${info.model} - Android ${info.version.release} (SDK ${info.version.sdkInt})',
        };
      } else if (Platform.isIOS) {
        final info = await deviceInfoPlugin.iosInfo;
        return {
          'model': info.model,
          'osVersion': '${info.systemName} ${info.systemVersion}',
          'fullInfo':
              '${info.model} - ${info.systemName} ${info.systemVersion}',
        };
      }
    } catch (e) {
      debugPrint('[AnonymousUserService] Device info error: $e');
    }
    return {'model': 'Unknown', 'osVersion': 'Unknown', 'fullInfo': 'Unknown'};
  }

  /// Link anonymous account with email and password.
  /// Returns true if linking was successful.
  Future<bool> linkWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || !user.isAnonymous) return false;

      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.linkWithCredential(credential);

      // Update user document
      await currentUserReference?.update({
        'email': email,
        'userType': 'registered',
        'account_created_source': 'email',
      });

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint('[AnonymousUserService] Link error: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /// Update user profile after account creation.
  Future<void> updateProfile({
    required String displayName,
    String? photoUrl,
    String? bio,
    String? department,
    String? batch,
    String? college,
    String? idNumber,
  }) async {
    final updates = <String, dynamic>{
      'display_name': displayName,
      'userType': 'registered',
      'profile_completion': 50,
    };
    if (photoUrl != null) updates['photo_url'] = photoUrl;
    if (bio != null) updates['bio'] = bio;
    if (department != null) updates['department'] = department;
    if (batch != null) updates['batch'] = batch;
    if (college != null) updates['collage'] = college;
    if (idNumber != null) updates['id_number'] = idNumber;

    await currentUserReference?.update(updates);

    // Also update Firebase Auth display name
    await FirebaseAuth.instance.currentUser?.updateDisplayName(displayName);
  }
}

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


/// Top-level handler for background FCM messages.
/// Must be a top-level function (not a class method).
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('[FCM] Background message: ${message.messageId}');
}

class PushNotificationService {
  static final PushNotificationService _instance =
      PushNotificationService._internal();
  factory PushNotificationService() => _instance;
  PushNotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  bool _initialized = false;

  /// Track current user to avoid duplicate setup calls
  String? _currentUid;

  /// Token refresh subscription so we can cancel on cleanup
  StreamSubscription<String>? _tokenRefreshSub;

  /// Android notification channel for FCM foreground messages
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'push_notifications',
    'Push Notifications',
    description: 'Notifications from AASTU Students App',
    importance: Importance.high,
  );

  /// Initialize FCM: request permissions, set up handlers, subscribe to topics.
  /// Call this after Firebase.initializeApp() and after the user is authenticated.
  Future<void> initialize() async {
    if (_initialized || kIsWeb) return;

    // Register the background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission (iOS shows a dialog, Android 13+ shows a dialog)
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    debugPrint('[FCM] Permission status: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint('[FCM] Notifications denied by user');
      return;
    }

    // Create the Android notification channel for foreground messages
    final localNotifications = FlutterLocalNotificationsPlugin();
    await localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // Show foreground notifications on iOS
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification taps (when app is in background/terminated)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Check if the app was opened from a terminated state via notification
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }

    _initialized = true;
    debugPrint('[FCM] Push notification service initialized');
  }

  /// Subscribe to topics and save FCM token for the current user.
  /// Call this after the user is authenticated.
  /// Safe to call multiple times — skips if already set up for this uid.
  Future<void> setupForUser(String uid) async {
    if (kIsWeb) return;

    // Skip if already set up for this user
    if (_currentUid == uid) return;
    _currentUid = uid;

    // Cancel previous token refresh listener if any
    await _tokenRefreshSub?.cancel();

    // Subscribe to topics (may fail on iOS if APNS token not yet available)
    try {
      await _messaging.subscribeToTopic('all_users');
      if (Platform.isAndroid) await _messaging.subscribeToTopic('android');
      if (Platform.isIOS) await _messaging.subscribeToTopic('ios');
      await _messaging.subscribeToTopic('user_$uid');
      debugPrint('[FCM] Subscribed to topics for user: $uid');
    } catch (e) {
      debugPrint('[FCM] Topic subscription failed (APNS token may not be ready): $e');
    }

    // Save FCM token to user document
    await _saveFcmToken(uid);

    // Listen for token refresh (single listener)
    _tokenRefreshSub = _messaging.onTokenRefresh.listen((newToken) {
      _updateTokenInFirestore(uid, newToken);
    });
  }

  /// Unsubscribe from user-specific topic on logout.
  Future<void> cleanupForUser(String uid) async {
    if (kIsWeb) return;
    try {
      await _messaging.unsubscribeFromTopic('user_$uid');
      debugPrint('[FCM] Unsubscribed from user topic: $uid');
    } catch (e) {
      debugPrint('[FCM] Topic unsubscribe failed (APNS token may not be ready): $e');
    }
    await _tokenRefreshSub?.cancel();
    _tokenRefreshSub = null;
    _currentUid = null;
  }

  Future<void> _saveFcmToken(String uid) async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        await _updateTokenInFirestore(uid, token);
      }
    } catch (e) {
      debugPrint('[FCM] Error saving token: $e');
    }
  }

  Future<void> _updateTokenInFirestore(String uid, String token) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'fcm_token': token,
      });
      debugPrint('[FCM] Token saved for user: $uid');
    } catch (e) {
      debugPrint('[FCM] Error updating token: $e');
    }
  }

  /// Show a local notification when a foreground FCM message arrives.
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('[FCM] Foreground message: ${message.notification?.title}');

    final notification = message.notification;
    if (notification == null) return;

    final localNotifications = FlutterLocalNotificationsPlugin();
    localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  /// Handle when user taps a notification (app was in background/terminated).
  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('[FCM] Notification tapped: ${message.data}');
    // Deep link handling can be added here based on message.data
  }
}

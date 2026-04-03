import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import '/flutter_flow/nav/nav.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse details) {
  // Background taps are handled when app relaunches
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  void _onNotificationTap(NotificationResponse details) {
    final payload = details.payload;
    if (payload == null || payload.isEmpty) return;

    final context = appNavigatorKey.currentContext;
    if (context == null) return;

    if (payload == 'DailyNegarit') {
      GoRouter.of(context).pushNamed('DailyNegarit');
    }
  }

  Future<void> initialize() async {
    if (_initialized || kIsWeb) return;

    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    _initialized = true;

    // Request permissions on Android 13+
    if (Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      // Request exact alarms permission for Android 12+
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestExactAlarmsPermission();
    }
    if (Platform.isIOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  /// Schedule a task reminder notification.
  /// [reminderMinutes] controls how many minutes before the task start time
  /// the notification fires (default: 15).
  Future<void> scheduleTaskReminder({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? category,
    int reminderMinutes = 15,
  }) async {
    if (kIsWeb || !_initialized) {
      debugPrint('[Notification] Skipped: web=$kIsWeb, initialized=$_initialized');
      return;
    }

    final reminderTime = scheduledTime.subtract(Duration(minutes: reminderMinutes));

    debugPrint('[Notification] Task time: $scheduledTime');
    debugPrint('[Notification] Remind $reminderMinutes min before => $reminderTime');
    debugPrint('[Notification] Now: ${DateTime.now()}');

    // Don't schedule if the reminder time is in the past
    if (reminderTime.isBefore(DateTime.now())) {
      debugPrint('[Notification] SKIPPED - reminder time is in the past');
      return;
    }

    final tzTime = tz.TZDateTime.from(reminderTime, tz.local);
    debugPrint('[Notification] Scheduling notification id=$id at $tzTime');

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tzTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_negarit_reminders',
          'Task Reminders',
          channelDescription: 'Reminders for your upcoming tasks',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          fullScreenIntent: true,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.timeSensitive,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'DailyNegarit',
    );
    debugPrint('[Notification] Successfully scheduled notification id=$id');
  }

  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    if (kIsWeb || !_initialized) return;

    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_negarit_updates',
          'Task Updates',
          channelDescription: 'Updates when tasks are completed',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future<void> cancelNotification(int id) async {
    if (kIsWeb || !_initialized) return;
    await _plugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    if (kIsWeb || !_initialized) return;
    await _plugin.cancelAll();
  }

  /// Generate a stable notification ID from a Firestore document path
  static int generateId(String documentPath) {
    return documentPath.hashCode.abs() % 2147483647;
  }
}

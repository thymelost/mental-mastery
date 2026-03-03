import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

/// Handles scheduling and cancellation of alarms for B6 meta-attention probes,
/// emotion check-ins, and practice reminders.
///
/// Call [AlarmService.instance.initialize] once in main() before runApp.
class AlarmService {
  AlarmService._();
  static final instance = AlarmService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  // ── Notification channel IDs ───────────────────────────────────────────────

  static const _channelProbe = 'meta_attention_probe';
  static const _channelCheckin = 'emotion_checkin';
  static const _channelReminder = 'practice_reminder';

  // ── Notification payload tokens ────────────────────────────────────────────

  static const payloadB6Probe = 'b6_probe';
  static const payloadCheckin = 'emotion_checkin';
  static const payloadReminder = 'practice_reminder';

  /// Returns the in-app route to navigate to when a notification with the
  /// given payload is tapped.
  static String? routeForPayload(String? payload) {
    return switch (payload) {
      payloadB6Probe => '/assessment/B6',
      payloadCheckin => '/journal/new?templateId=T03',
      _ => null,
    };
  }

  // ── Initialization ─────────────────────────────────────────────────────────

  Future<void> initialize({
    required void Function(String? payload) onTap,
  }) async {
    if (_initialized) return;

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        onTap(response.payload);
      },
    );

    // Create notification channels.
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      await androidImpl.requestNotificationsPermission();
      await androidImpl.createNotificationChannel(
        const AndroidNotificationChannel(
          _channelProbe,
          'Meta-Attention Probes',
          description: 'B6 random probes — where is your attention?',
          importance: Importance.high,
          enableVibration: true,
        ),
      );
      await androidImpl.createNotificationChannel(
        const AndroidNotificationChannel(
          _channelCheckin,
          'Emotion Check-ins',
          description: 'Periodic emotional state check-ins.',
          importance: Importance.defaultImportance,
        ),
      );
      await androidImpl.createNotificationChannel(
        const AndroidNotificationChannel(
          _channelReminder,
          'Practice Reminders',
          description: 'Scheduled practice session reminders.',
          importance: Importance.defaultImportance,
        ),
      );
    }

    _initialized = true;
  }

  // ── B6 probe scheduling ────────────────────────────────────────────────────

  /// Schedule [count] random B6 probes spread across the next [windowHours]
  /// hours. Uses [baseId] as the starting notification ID.
  ///
  /// Probes are randomised within the window so the user cannot predict them.
  Future<void> scheduleB6Probes({
    int count = 5,
    int windowHours = 14,
    int baseId = 1000,
  }) async {
    if (!_initialized) return;
    final rng = Random();
    final now = tz.TZDateTime.now(tz.local);

    for (var i = 0; i < count; i++) {
      // Random offset within the window (minutes).
      final offsetMinutes =
          rng.nextInt(windowHours * 60 - 30) + 15;
      final scheduledTime =
          now.add(Duration(minutes: offsetMinutes));

      await _plugin.zonedSchedule(
        baseId + i,
        'Where is your attention?',
        'Tap to log your B6 meta-attention probe.',
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelProbe,
            'Meta-Attention Probes',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payloadB6Probe,
      );
    }
  }

  /// Show an immediate B6 probe notification (used for testing).
  Future<void> showB6ProbeNow({int id = 999}) async {
    if (!_initialized) return;
    await _plugin.show(
      id,
      'Where is your attention?',
      'Tap to log your B6 meta-attention probe.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelProbe,
          'Meta-Attention Probes',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: payloadB6Probe,
    );
  }

  // ── Practice reminder ─────────────────────────────────────────────────────

  /// Schedule a daily practice reminder at [hour]:[minute].
  Future<void> scheduleDailyPracticeReminder({
    int hour = 8,
    int minute = 0,
    int id = 2000,
  }) async {
    if (!_initialized) return;
    final now = tz.TZDateTime.now(tz.local);
    var scheduledTime =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id,
      'Mental Mastery',
      'Time for your morning practice session.',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelReminder,
          'Practice Reminders',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payloadReminder,
    );
  }

  // ── Cancellation ──────────────────────────────────────────────────────────

  Future<void> cancelB6Probes({int baseId = 1000, int count = 5}) async {
    for (var i = 0; i < count; i++) {
      await _plugin.cancel(baseId + i);
    }
  }

  Future<void> cancelPracticeReminder({int id = 2000}) async {
    await _plugin.cancel(id);
  }

  Future<void> cancelAll() => _plugin.cancelAll();
}

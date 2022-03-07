import 'dart:convert';

import 'package:flutter_alarm_app/src/app.dart';
import 'package:flutter_alarm_app/src/models/notification_payload_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  //NotificationService a singleton object
  static final NotificationHelper _notificationHelper = NotificationHelper._internal();

  factory NotificationHelper() {
    return _notificationHelper;
  }

  NotificationHelper._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Called on init
  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: _selectNotification);
  }

  final AndroidNotificationDetails _androidNotificationDetails = const AndroidNotificationDetails(
    '0',
    'Alarm',
    channelDescription: 'Alarm triggered',
    priority: Priority.high,
    importance: Importance.max,
  );

  Future<void> scheduleNotifications({
    required String title,
    required String body,
    required DateTime dateTime,
    String? payload,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      NotificationDetails(android: _androidNotificationDetails),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  /// Called when user tapped on the notification
  Future<void> _selectNotification(String? payload) async {
    if (payload == null) {
      return;
    }

    final NotificationPayloadModel notificationPayloadModel =
    NotificationPayloadModel.fromJson(jsonDecode(payload) as Map<String, dynamic>);
    navigatorKey.currentState
        ?.pushNamed(notificationPayloadModel.path, arguments: notificationPayloadModel.alarmDateTimeString);
  }

  /// Called when app launched from notification
  Future<void> runNotificationAfterAppIsTerminated() async {
    final NotificationAppLaunchDetails? details =
    await NotificationHelper().flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (details?.didNotificationLaunchApp == true) {
      if (details!.payload != null) {
        final NotificationPayloadModel notificationPayloadModel =
        NotificationPayloadModel.fromJson(jsonDecode(details.payload!) as Map<String, dynamic>);
        navigatorKey.currentState
            ?.pushNamed(notificationPayloadModel.path, arguments: notificationPayloadModel.alarmDateTimeString);
      }
    }
  }
}

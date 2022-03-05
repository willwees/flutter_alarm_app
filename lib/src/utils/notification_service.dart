import 'dart:convert';

import 'package:flutter_alarm_app/src/app.dart';
import 'package:flutter_alarm_app/src/model/notification_payload_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
  }

  final AndroidNotificationDetails _androidNotificationDetails = const AndroidNotificationDetails(
    '0',
    'Alarm',
    channelDescription: 'Alarm triggered',
    priority: Priority.high,
    importance: Importance.max,
  );

  Future<void> showNotifications() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification Title',
      'This is the Notification Body!',
      NotificationDetails(android: _androidNotificationDetails),
    );
  }

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

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future<void> selectNotification(String? payload) async {
  if (payload == null) {
    return;
  }

  final NotificationPayloadModel notificationPayloadModel =
      NotificationPayloadModel.fromJson(jsonDecode(payload) as Map<String, dynamic>);
  navigatorKey.currentState
      ?.pushNamed(notificationPayloadModel.path, arguments: notificationPayloadModel.alarmDateTimeString);
}

Future<void> runNotificationAfterAppIsTerminated() async {
  final NotificationAppLaunchDetails? details =
      await NotificationService().flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (details?.didNotificationLaunchApp == true) {
    if (details!.payload != null) {
      print('payload: ${details.payload}');

      final NotificationPayloadModel notificationPayloadModel =
          NotificationPayloadModel.fromJson(jsonDecode(details.payload!) as Map<String, dynamic>);
      navigatorKey.currentState
          ?.pushNamed(notificationPayloadModel.path, arguments: notificationPayloadModel.alarmDateTimeString);
    }
  }
}

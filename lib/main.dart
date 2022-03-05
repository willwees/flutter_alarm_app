import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/app.dart';
import 'package:flutter_alarm_app/src/utils/notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService().init();
  runApp(const App());
}

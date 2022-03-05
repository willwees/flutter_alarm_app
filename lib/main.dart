import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/app.dart';
import 'package:flutter_alarm_app/src/utils/notification_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationHelper().init();
  runApp(const App());
}

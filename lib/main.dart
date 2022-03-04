import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alarm_app/src/app.dart';

void main() {
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, // Color for Android
      statusBarBrightness: Brightness.light, // Dark == white status bar -- for IOS.
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const App());
}

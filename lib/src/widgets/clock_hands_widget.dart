import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/utils/painter/clock_hour_hand_painter.dart';
import 'package:flutter_alarm_app/src/utils/painter/clock_minute_hand_painter.dart';
import 'package:flutter_alarm_app/src/utils/painter/clock_second_hand_painter.dart';

class ClockHandsWidget extends StatelessWidget {
  const ClockHandsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            CustomPaint(
              painter: ClockHourHandPainter(hours: 1),
            ),
            CustomPaint(
              painter: ClockMinuteHandPainter(minutes: 4),
            ),
            CustomPaint(
              painter: ClockSecondHandPainter(seconds: 28),
            ),
          ],
        ),
      ),
    );
  }
}

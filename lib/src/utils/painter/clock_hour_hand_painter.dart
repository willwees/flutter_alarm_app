import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom painter to draw clock hour hand
class ClockHourHandPainter extends CustomPainter {
  final double _hourHandLength = 200.0.w;

  final Paint _hourHandPaint = Paint()
    ..color = AppColors.kBlack2
    ..strokeWidth = 20.0.w;
  final int hours;

  ClockHourHandPainter({
    this.hours = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;

    // save position before translate
    canvas.save();

    // move position to the middle of canvas
    canvas.translate(radius, radius);

    // rotate canvas
    canvas.rotate(2 * pi * (hours / 12));

    // draw the hour hand
    canvas.drawLine(Offset(0.0, _hourHandLength / 6), Offset(0.0, -_hourHandLength), _hourHandPaint);

    // restore to initial position
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

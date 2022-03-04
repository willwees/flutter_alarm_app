import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom painter to draw clock hour hand
class ClockMinuteHandPainter extends CustomPainter {
  final double _minuteHandLength = 280.0.w;

  final Paint _minuteHandPaint = Paint()
    ..color = AppColors.kBlack2
    ..strokeWidth = 12.0.w;
  final int minutes;

  ClockMinuteHandPainter({
    this.minutes = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;

    // save position before translate
    canvas.save();

    // move position to the middle of canvas
    canvas.translate(radius, radius);

    // rotate canvas
    canvas.rotate(2 * pi * (minutes / 60));

    // draw the hour hand
    canvas.drawLine(Offset(0.0, _minuteHandLength / 6), Offset(0.0, -_minuteHandLength), _minuteHandPaint);

    // restore to initial position
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom painter to draw clock hour hand
class ClockSecondHandPainter extends CustomPainter {
  final double _secondHandLength = 280.0.w;

  final Paint _secondHandPaint = Paint()
    ..color = AppColors.kRed
    ..strokeWidth = 4.0.w;
  final int seconds;

  ClockSecondHandPainter({
    this.seconds = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;

    // save position before translate
    canvas.save();

    // move position to the middle of canvas
    canvas.translate(radius, radius);

    // rotate canvas
    canvas.rotate(2 * pi * (seconds / 60));

    // draw the hour hand
    canvas.drawLine(Offset(0.0, _secondHandLength / 6), Offset(0.0, -_secondHandLength), _secondHandPaint);

    // restore to initial position
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

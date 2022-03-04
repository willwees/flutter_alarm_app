import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom painter to draw clock dials and numbers
class ClockDialPainter extends CustomPainter {
  static const double _angle = 2 * pi / 60; // ~6 degrees

  final double _minuteTickMarkStrokeWidth = 2.0.w;
  final double _hourTickMarkStrokeWidth = 4.0.w;
  final double _tickMarkLength = 10.0.w;

  final Paint _tickPaint = Paint();
  final TextPainter _textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;

    // save position before translate
    canvas.save();

    // move position to the middle of canvas
    canvas.translate(radius, radius);

    // loop until 60 ticks
    for (int i = 0; i < 60; i++) {
      // make the stroke width of the tick marker thicker every 5 ticks
      _tickPaint.strokeWidth = i % 5 == 0 ? _hourTickMarkStrokeWidth : _minuteTickMarkStrokeWidth;

      // draw the dial
      canvas.drawLine(Offset(0.0, -radius), Offset(0.0, -radius + _tickMarkLength), _tickPaint);

      //draw the number every 5 ticks
      if (i % 5 == 0) {
        _drawText(i, canvas, radius);
      }

      // rotate the canvas by ~6 degrees
      canvas.rotate(_angle);
    }

    // restore to initial position
    canvas.restore();
  }

  void _drawText(int i, Canvas canvas, double radius) {
    canvas.save();

    // move position to top
    canvas.translate(0.0, -radius + 50.0.w);

    // set text value
    _textPainter.text = TextSpan(
      text: '${i == 0 ? 12 : i ~/ 5}',
      style: TextStyle(
        color: AppColors.kBlack,
        fontSize: 36.0.sp,
      ),
    );

    // make the text painted vertically
    canvas.rotate(-_angle * i);

    // draw the text
    _textPainter.layout();
    _textPainter.paint(canvas, Offset(-(_textPainter.width / 2), -(_textPainter.height / 2)));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

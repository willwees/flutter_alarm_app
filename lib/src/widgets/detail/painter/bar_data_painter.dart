import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_alarm_app/src/utils/date_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarDataPainter extends CustomPainter {
  final Paint _paint = Paint()..color = Colors.blue;

  final TextPainter _textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  final int value;
  final int maxValue;
  final double valueHeightRatio;
  final double lineStrokeWidth;
  final int tickCount;
  final double arrowLineLength;

  BarDataPainter({
    required this.value,
    required this.maxValue,
    required this.valueHeightRatio,
    required this.lineStrokeWidth,
    required this.tickCount,
    required this.arrowLineLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Determine bar width & height
    _paint.strokeWidth = _getBarWidth();
    final double barHeight = _getBarHeight(size);

    // Draw bar
    _drawBar(canvas, size, barHeight);

    // Draw text
    _drawText(canvas, size, barHeight);
  }

  /// Calculate bar width
  double _getBarWidth() {
    _textPainter.text = TextSpan(
      text: DateHelper.numberToThousandSeparatorFormat(maxValue),
      style: TextStyle(
        color: AppColors.kBlack,
        fontSize: 24.0.sp,
      ),
    );
    _textPainter.layout();
    return max(100.0.w, _textPainter.width); // set minimum bar width to 100.0.w
  }

  /// Calculate bar height
  double _getBarHeight(Size size) {
    final double startPoint = size.width - arrowLineLength - lineStrokeWidth;
    final double barHeight = startPoint * valueHeightRatio * (tickCount - 1) / tickCount;

    return barHeight;
  }

  /// Draw bar
  void _drawBar(Canvas canvas, Size size, double barHeight) {
    canvas.save();
    canvas.translate(
      size.width - (size.width - _textPainter.width) / 2,
      size.width - arrowLineLength - lineStrokeWidth / 2,
    );

    // Draw main line
    canvas.drawLine(Offset.zero, Offset(0.0, -barHeight), _paint);

    canvas.restore();
  }

  /// Draw text
  void _drawText(Canvas canvas, Size size, double barHeight) {
    canvas.save();
    canvas.translate(
      size.width - (size.width - _textPainter.width) / 2,
      size.width - arrowLineLength - lineStrokeWidth / 2,
    );

    // Draw text
    _textPainter.text = TextSpan(
      text: DateHelper.numberToThousandSeparatorFormat(value),
      style: TextStyle(
        color: AppColors.kBlack,
        fontSize: 24.0.sp,
      ),
    );
    _textPainter.layout();
    _textPainter.paint(
      canvas,
      Offset(
        -(_textPainter.width / 2),
        -_textPainter.height - barHeight,
      ),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

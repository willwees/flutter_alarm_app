import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_alarm_app/src/utils/date_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarDataPainter extends CustomPainter {
  final double _lineStrokeWidth = 8.0.w; // from bar axis painter
  final int _tickCount = 6; // from bar axis painter
  final double _arrowLineLength = 30.0.w; // from bar axis painter

  final Paint _paint = Paint()..color = Colors.blue;

  /// Used to get the Y-Axis text width
  final TextPainter _textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  final int value;
  final int maxValue;

  BarDataPainter({
    required this.value,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _textPainter.text = TextSpan(
      text: DateHelper.numberToThousandSeparatorFormat(maxValue),
      style: TextStyle(
        color: AppColors.kBlack,
        fontSize: 24.0.sp,
      ),
    );
    _textPainter.layout();
    _paint.strokeWidth = _textPainter.width;

    // Draw bar
    _drawBar(canvas, size);
  }

  /// Draw bar
  void _drawBar(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(
      size.width - (size.width - _textPainter.width) / 2,
      size.width - _arrowLineLength - _lineStrokeWidth / 2,
    );

    // Draw main line
    final double startPoint = size.width - _arrowLineLength - _lineStrokeWidth;
    final double valueRatio = value / maxValue;
    canvas.drawLine(Offset.zero, Offset(0.0, -startPoint * valueRatio * (_tickCount - 1) / _tickCount), _paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

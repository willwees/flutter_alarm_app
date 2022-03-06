import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_alarm_app/src/utils/date_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarDataPainter extends CustomPainter {
  final Paint _paint = Paint()..color = Colors.blue;

  /// Used to get the Y-Axis text width
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
      size.width - arrowLineLength - lineStrokeWidth / 2,
    );

    // Draw main line
    final double startPoint = size.width - arrowLineLength - lineStrokeWidth;
    canvas.drawLine(Offset.zero, Offset(0.0, -startPoint * valueHeightRatio * (tickCount - 1) / tickCount), _paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

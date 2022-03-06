import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_alarm_app/src/utils/date_helper.dart';
import 'package:flutter_alarm_app/src/utils/math_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarAxisPainter extends CustomPainter {
  final double _lineStrokeWidth = 8.0.w;
  final double _tickStrokeWidth = 4.0.w;
  final double _tickLength = 20.0.w;
  final int _tickCount = 6;
  final double _arrowLineLength = 30.0.w;

  final Paint _linePaint = Paint()..strokeCap = StrokeCap.round;
  final Paint _tickPaint = Paint();
  final TextPainter _textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  final String alarmText;
  final int maxValue;

  BarAxisPainter({
    required this.alarmText,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _linePaint.strokeWidth = _lineStrokeWidth;
    _tickPaint.strokeWidth = _tickStrokeWidth;
    _drawYAxis(canvas, size);
    _drawXAxis(canvas, size);
  }

  /// Draw Y-axis
  void _drawYAxis(Canvas canvas, Size size) {
    canvas.save();

    _textPainter.text = TextSpan(
      text: DateHelper.numberToThousandSeparatorFormat(maxValue),
      style: TextStyle(
        color: AppColors.kBlack,
        fontSize: 24.0.sp,
      ),
    );
    _textPainter.layout();
    canvas.translate(_textPainter.width, 0.0);

    // Draw main line
    canvas.drawLine(Offset.zero, Offset(0.0, size.width), _linePaint);

    // Draw arrow
    _drawArrow(canvas);

    // Draw tick & number
    _drawYAxisTickAndNumber(canvas, size);

    canvas.restore();
  }

  /// Draw Y-axis tick and number
  void _drawYAxisTickAndNumber(Canvas canvas, Size size) {
    for (int i = 0; i < _tickCount; i++) {
      canvas.save();

      // Draw tick
      final double startPoint = size.width - _arrowLineLength;
      canvas.translate(0.0, startPoint - startPoint / _tickCount * i);
      canvas.drawLine(Offset(-_tickLength / 2, 0.0), Offset(_tickLength / 2, 0.0), _tickPaint);

      // Draw text
      if (i != 0) {
        _drawNumberText(canvas, i);
      }

      canvas.restore();
    }
  }

  /// Draw Y-axis number
  void _drawNumberText(Canvas canvas, int i) {
    canvas.save();
    canvas.translate(-_arrowLineLength, 0.0);

    _textPainter.text = TextSpan(
      text: DateHelper.numberToThousandSeparatorFormat(i * maxValue ~/ (_tickCount - 1)),
      style: TextStyle(
        color: AppColors.kBlack,
        fontSize: 24.0.sp,
      ),
    );
    _textPainter.layout();
    _textPainter.paint(canvas, Offset(-_textPainter.width + _arrowLineLength / 2, -(_textPainter.height / 2)));

    canvas.restore();
  }

  /// Draw X-axis
  void _drawXAxis(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width, size.width - _arrowLineLength);
    canvas.rotate(90.degrees);

    // Draw main line
    canvas.drawLine(Offset.zero, Offset(0.0, size.width), _linePaint);

    // Draw arrow
    _drawArrow(canvas);

    // Draw tick and date
    _drawXAxisTickAndDate(canvas, size);

    canvas.restore();
  }

  /// Draw X-axis tick
  void _drawXAxisTickAndDate(Canvas canvas, Size size) {
    canvas.save();

    canvas.translate(0.0, (size.width - _textPainter.width) / 2);
    canvas.drawLine(Offset(-_tickLength / 2, 0.0), Offset(_tickLength / 2, 0.0), _tickPaint);

    // Draw date text
    _drawDateText(canvas, size);

    canvas.restore();
  }

  /// Draw X-axis date
  void _drawDateText(Canvas canvas, Size size) {
    canvas.save();
    canvas.rotate(-90.degrees);

    _textPainter.text = TextSpan(
      text: alarmText,
      style: TextStyle(
        color: AppColors.kBlack,
        fontSize: 24.0.sp,
      ),
    );
    _textPainter.layout();
    _textPainter.paint(canvas, Offset(-(_textPainter.width / 2), _arrowLineLength - (_textPainter.height / 2)));

    canvas.restore();
  }

  /// Draw Arrow
  void _drawArrow(Canvas canvas) {
    canvas.save();
    canvas.rotate(45.degrees);
    canvas.drawLine(Offset.zero, Offset(0.0, _arrowLineLength + _lineStrokeWidth / 2), _linePaint);
    canvas.rotate(-90.degrees);
    canvas.drawLine(Offset.zero, Offset(0.0, _arrowLineLength + _lineStrokeWidth / 2), _linePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

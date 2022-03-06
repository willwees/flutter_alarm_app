import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_alarm_app/src/utils/date_helper.dart';
import 'package:flutter_alarm_app/src/widgets/detail/painter/bar_axis_painter.dart';
import 'package:flutter_alarm_app/src/widgets/detail/painter/bar_data_painter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarChartWidget extends StatefulWidget {
  final DateTime alarmDateTime;
  final int alarmDiffSeconds;
  final int alarmMaxDiffSeconds;

  const BarChartWidget({
    Key? key,
    required this.alarmDateTime,
    required this.alarmDiffSeconds,
    required this.alarmMaxDiffSeconds,
  }) : super(key: key);

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> with TickerProviderStateMixin {
  late final Animation<double> _animation;
  late final AnimationController _animationController;

  // add the painter parameters here so it can be shared between bar painters
  final double _lineStrokeWidth = 8.0.w;
  late final int _yTickCount;
  final double _arrowLineLength = 30.0.w;

  @override
  void initState() {
    super.initState();

    // determine bar tick
    _yTickCount = min(6, widget.alarmMaxDiffSeconds + 1);

    // init animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    final Tween<double> _barHeightTween = Tween<double>(
      begin: 0.0,
      end: widget.alarmDiffSeconds / widget.alarmMaxDiffSeconds,
    );
    _animation = _barHeightTween.animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        color: AppColors.kWhite2,
        padding: EdgeInsets.all(16.0.w),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Bar Axis
            CustomPaint(
              painter: BarAxisPainter(
                alarmText: DateHelper.dateTimeToString(widget.alarmDateTime),
                maxValue: widget.alarmMaxDiffSeconds,
                lineStrokeWidth: _lineStrokeWidth,
                tickCount: _yTickCount,
                arrowLineLength: _arrowLineLength,
              ),
            ),
            // Bar Data
            CustomPaint(
              painter: BarDataPainter(
                value: widget.alarmDiffSeconds,
                maxValue: widget.alarmMaxDiffSeconds,
                valueHeightRatio: _animation.value,
                lineStrokeWidth: _lineStrokeWidth,
                tickCount: _yTickCount,
                arrowLineLength: _arrowLineLength,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

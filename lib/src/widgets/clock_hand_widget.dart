import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_alarm_app/src/constants/device_properties.dart';
import 'package:flutter_alarm_app/src/utils/math_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClockHandWidget extends StatelessWidget {
  final int value;
  final Function(int) onPanUpdate;
  final int interval;
  final double clockHandWidth;
  final double clockHandInvisibleWidth; // so user can tap more easily.
  final double clockHandHeight;
  final double pivot;
  final Color color;

  ClockHandWidget({
    Key? key,
    required this.value,
    required this.onPanUpdate,
    required this.interval,
    required this.clockHandWidth,
    required this.clockHandInvisibleWidth,
    required this.clockHandHeight,
    required this.pivot,
    required this.color,
  }) : super(key: key);

  final double _padding = 48.0.w;
  late final double _centerOffsetCoord = kDeviceLogicalWidth / 2 - (_padding + clockHandInvisibleWidth / 2);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        _centerOffsetCoord,
        _centerOffsetCoord - (clockHandInvisibleWidth + clockHandHeight) / 2 - pivot + clockHandInvisibleWidth,
      ),
      child: Transform.rotate(
        angle: 2 * pi * (value / interval),
        origin: Offset(0.0, pivot),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: (DragUpdateDetails details) => _onPanUpdate(details, context),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: clockHandInvisibleWidth,
                height: clockHandHeight,
                color: Colors.transparent,
              ),
              Container(
                width: clockHandWidth,
                height: clockHandHeight,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPanUpdate(DragUpdateDetails details, BuildContext context) {
    // get cursor position
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    final Offset? position = renderBox?.globalToLocal(details.globalPosition);
    if (position == null) {
      return;
    }

    // calculate new value
    final double angle = coordinatesToRadians(Offset(_centerOffsetCoord, _centerOffsetCoord), position);
    final double percentage = radiansToPercentage(angle);
    final int newValue = percentageToValue(percentage, interval);

    onPanUpdate(newValue);
  }

  factory ClockHandWidget.hours({
    required int value,
    required Function(int) onPanUpdate,
  }) {
    return ClockHandWidget(
      value: value,
      onPanUpdate: onPanUpdate,
      interval: 12,
      clockHandWidth: 20.0.w,
      clockHandInvisibleWidth: 30.0.w,
      clockHandHeight: 200.0.w,
      pivot: 60.0.w,
      color: AppColors.kBlack2,
    );
  }

  factory ClockHandWidget.minutes({
    required int value,
    required Function(int) onPanUpdate,
  }) {
    return ClockHandWidget(
      value: value,
      onPanUpdate: onPanUpdate,
      interval: 60,
      clockHandWidth: 12.0.w,
      clockHandInvisibleWidth: 30.0.w,
      clockHandHeight: 280.0.w,
      pivot: 90.0.w,
      color: AppColors.kBlack2,
    );
  }

  factory ClockHandWidget.seconds({
    required int value,
    required Function(int) onPanUpdate,
  }) {
    return ClockHandWidget(
      value: value,
      onPanUpdate: onPanUpdate,
      interval: 60,
      clockHandWidth: 4.0.w,
      clockHandInvisibleWidth: 30.0.w,
      clockHandHeight: 280.0.w,
      pivot: 90.0.w,
      color: AppColors.kRed,
    );
  }
}

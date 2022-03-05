import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_alarm_app/src/constants/device_properties.dart';
import 'package:flutter_alarm_app/src/utils/gesture_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClockHourHandWidget extends StatelessWidget {
  final int hours;
  final Function(int) onPanUpdate;

  ClockHourHandWidget({
    Key? key,
    required this.hours,
    required this.onPanUpdate,
  }) : super(key: key);

  final double _padding = 48.0.w;
  final double _clockHandWidth = 20.0.w;
  final double _clockHandHeight = 200.0.w;
  final double _pivot = 60.0.w;
  late final double _centerOffsetCoord = kDeviceLogicalWidth / 2 - (_padding + _clockHandWidth / 2);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        _centerOffsetCoord,
        _centerOffsetCoord - (_clockHandWidth + _clockHandHeight) / 2 - _pivot + _clockHandWidth,
      ),
      child: Transform.rotate(
        angle: 2 * pi * (hours / 12),
        origin: Offset(0.0, _pivot),
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) => _onPanUpdate(details, context),
          child: Container(
            width: _clockHandWidth,
            height: _clockHandHeight,
            color: AppColors.kBlack2,
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
    final int newHours = percentageToValue(percentage, 12);

    onPanUpdate(newHours);
  }
}

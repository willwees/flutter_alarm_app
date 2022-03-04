import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_alarm_app/src/constants/device_properties.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClockHourHandWidget extends StatefulWidget {
  final int hours;

  const ClockHourHandWidget({
    Key? key,
    this.hours = 3,
  }) : super(key: key);

  @override
  State<ClockHourHandWidget> createState() => _ClockHourHandWidgetState();
}

class _ClockHourHandWidgetState extends State<ClockHourHandWidget> {
  @override
  Widget build(BuildContext context) {
    final double padding = 48.0.w;
    final double clockHandWidth = 20.0.w;
    final double clockHandHeight = 200.0.w;
    final double centerOffset = kDeviceLogicalWidth / 2 - (padding + clockHandWidth / 2);
    final double pivot = 60.0.w;

    return Transform.translate(
      offset: Offset(
        centerOffset,
        centerOffset - (clockHandWidth + clockHandHeight) / 2 - pivot + clockHandWidth,
      ),
      child: Transform.rotate(
        angle: 2 * pi * (widget.hours / 12),
        origin: Offset(0.0, pivot),
        child: GestureDetector(
          onPanDown: _onPanDown,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: Container(
            width: clockHandWidth,
            height: clockHandHeight,
            color: AppColors.kBlack2,
          ),
        ),
      ),
    );
  }

  void _onPanDown(DragDownDetails details) {
    print('panDown!');
  }

  void _onPanUpdate(DragUpdateDetails details) {
    print('panUpdate!');
  }

  void _onPanEnd(_) {
    print('panEnd!');
  }
}

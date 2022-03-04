import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_alarm_app/src/constants/device_properties.dart';
import 'package:flutter_alarm_app/src/utils/gesture_helper.dart';
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
  final double _padding = 48.0.w;
  final double _clockHandWidth = 20.0.w;
  final double _clockHandHeight = 200.0.w;
  final double _pivot = 60.0.w;
  late final double _centerOffsetCoord;
  late int _hours;

  @override
  void initState() {
    super.initState();

    _centerOffsetCoord = kDeviceLogicalWidth / 2 - (_padding + _clockHandWidth / 2);
    _hours = widget.hours;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        _centerOffsetCoord,
        _centerOffsetCoord - (_clockHandWidth + _clockHandHeight) / 2 - _pivot + _clockHandWidth,
      ),
      child: Transform.rotate(
        angle: 2 * pi * (_hours / 12),
        origin: Offset(0.0, _pivot),
        child: GestureDetector(
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: Container(
            width: _clockHandWidth,
            height: _clockHandHeight,
            color: AppColors.kBlack2,
          ),
        ),
      ),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    // get cursor position
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    final Offset? position = renderBox?.globalToLocal(details.globalPosition);
    if (position == null) {
      return;
    }

    // calculate new value
    final double angle = coordinatesToRadians(Offset(_centerOffsetCoord, _centerOffsetCoord), position);
    final double percentage = radiansToPercentage(angle);
    final int newValue = percentageToValue(percentage, 12);

    setState(() {
      _hours = newValue;
    });
  }

  void _onPanEnd(_) {
    print('panEnd!');
    //TODO: call event
  }
}

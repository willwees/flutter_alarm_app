import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_alarm_app/src/constants/device_properties.dart';
import 'package:flutter_alarm_app/src/utils/gesture_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClockSecondHandWidget extends StatefulWidget {
  final int seconds;

  const ClockSecondHandWidget({
    Key? key,
    this.seconds = 50,
  }) : super(key: key);

  @override
  State<ClockSecondHandWidget> createState() => _ClockSecondHandWidgetState();
}

class _ClockSecondHandWidgetState extends State<ClockSecondHandWidget> {
  final double _padding = 48.0.w;
  final double _clockHandWidth = 4.0.w;
  final double _clockHandInvisibleWidth = 20.0.w; // so user can tap more easily.
  final double _clockHandHeight = 280.0.w;
  final double _pivot = 90.0.w;
  late final double _centerOffsetCoord;
  late int _seconds;

  @override
  void initState() {
    super.initState();

    _centerOffsetCoord = kDeviceLogicalWidth / 2 - (_padding + _clockHandInvisibleWidth / 2);
    _seconds = widget.seconds;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        _centerOffsetCoord,
        _centerOffsetCoord - (_clockHandInvisibleWidth + _clockHandHeight) / 2 - _pivot + _clockHandInvisibleWidth,
      ),
      child: Transform.rotate(
        angle: 2 * pi * (_seconds / 60),
        origin: Offset(0.0, _pivot),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: _clockHandInvisibleWidth,
                height: _clockHandHeight,
                color: Colors.transparent,
              ),
              Container(
                width: _clockHandWidth,
                height: _clockHandHeight,
                color: AppColors.kRed,
              ),
            ],
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
    final int newValue = percentageToValue(percentage, 60);

    setState(() {
      _seconds = newValue;
    });
  }

  void _onPanEnd(_) {
    print('panEnd!');
    //TODO: call event
  }
}

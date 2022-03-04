import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClockHourHandWidget extends StatelessWidget {
  final int hours;

  const ClockHourHandWidget({Key? key, this.hours = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 0),
      child: GestureDetector(
        onPanDown: _onPanDown,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: Transform.rotate(
          angle: 2 * pi * (hours / 12),
          child: Container(
            width: 20.0.w,
            height: 200.0.w,
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

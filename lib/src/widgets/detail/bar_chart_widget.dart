import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/utils/date_helper.dart';
import 'package:flutter_alarm_app/src/widgets/detail/painter/bar_axis_painter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarChartWidget extends StatelessWidget {
  final DateTime alarmDateTime;
  final int alarmDiffSeconds;

  const BarChartWidget({
    Key? key,
    required this.alarmDateTime,
    required this.alarmDiffSeconds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        //TODO: temp color
        color: Colors.green,
        padding: EdgeInsets.all(16.0.w),
        child: CustomPaint(
          painter: BarAxisPainter(
            alarmText: DateHelper.dateTimeToString(alarmDateTime),
            multiplier: alarmDiffSeconds ~/ 5,
          ),
        ),
      ),
    );
  }
}

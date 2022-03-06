import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/blocs/home/home_bloc.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClockModeWidget extends StatelessWidget {
  final VoidCallback onTap;
  final ClockMode clockMode;
  final ClockMode activeClockMode;

  const ClockModeWidget({
    Key? key,
    required this.onTap,
    required this.clockMode,
    required this.activeClockMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0.w),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: Colors.blue,
          ),
          borderRadius: clockMode == ClockMode.modeAM
              ? BorderRadius.horizontal(left: Radius.circular(14.0.r))
              : BorderRadius.horizontal(right: Radius.circular(14.0.r)),
          color: activeClockMode == clockMode ? Colors.blue : null,
        ),
        child: Text(
          clockMode == ClockMode.modeAM ? 'AM' : 'PM',
          style: TextStyle(
            fontSize: 40.0.sp,
            fontWeight: FontWeight.bold,
            color: activeClockMode == clockMode ? AppColors.kWhite : Colors.blue,
          ),
        ),
      ),
    );
  }
}

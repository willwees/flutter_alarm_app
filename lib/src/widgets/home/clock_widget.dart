import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_alarm_app/src/widgets/home/clock_hand_widget.dart';
import 'package:flutter_alarm_app/src/widgets/home/painter/clock_dial_painter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClockWidget extends StatelessWidget {
  final int hours;
  final int minutes;
  final int seconds;
  final Function(int newHours) onHourPanUpdate;
  final Function(int newMinutes) onMinutesPanUpdate;
  final Function(int newSeconds) onSecondsPanUpdate;

  const ClockWidget({
    Key? key,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.onHourPanUpdate,
    required this.onMinutesPanUpdate,
    required this.onSecondsPanUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        children: <Widget>[
          _buildBodyClock(),
          _buildFaceClock(),
        ],
      ),
    );
  }

  /// Clock body
  Widget _buildBodyClock() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            AppColors.kWhite3,
            AppColors.kGrey,
            AppColors.kGrey2,
            AppColors.kGrey,
          ],
        ),
        color: AppColors.kGrey,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 5.0,
          )
        ],
      ),
    );
  }

  /// Clock face
  Widget _buildFaceClock() {
    return Padding(
      padding: EdgeInsets.all(40.0.w),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                AppColors.kWhite2,
                AppColors.kGrey,
              ],
              stops: <double>[
                0.9,
                1.0,
              ],
            ),
            color: AppColors.kWhite2,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.kGrey2,
                blurRadius: 50.0,
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              // Clock dial & number
              _buildClockDialAndNumber(),
              // Clock hands
              _buildClockHandsWidget(),
              // Center dot
              _buildClockCenterDot(),
            ],
          ),
        ),
      ),
    );
  }

  /// Clock dials
  Widget _buildClockDialAndNumber() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(10.0.w),
      child: CustomPaint(
        painter: ClockDialPainter(),
      ),
    );
  }

  /// Clock hands
  Widget _buildClockHandsWidget() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            ClockHandWidget.hours(
              value: hours * 60 + (minutes.toDouble() % 60).floor(), // convert to degrees hour (0-720)
              onPanUpdate: onHourPanUpdate,
            ),
            ClockHandWidget.minutes(
              value: minutes,
              onPanUpdate: onMinutesPanUpdate,
            ),
            ClockHandWidget.seconds(
              value: seconds,
              onPanUpdate: onSecondsPanUpdate,
            ),
          ],
        ),
      ),
    );
  }

  /// Center dot
  Widget _buildClockCenterDot() {
    return Center(
      child: Container(
        width: 10.0.w,
        height: 10.0.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}

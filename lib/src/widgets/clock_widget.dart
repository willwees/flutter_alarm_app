import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({Key? key}) : super(key: key);

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
              //TODO: clock numbers
              //TODO: clock hands
              // Center Dot
              Center(
                child: Container(
                  width: 5.0.w,
                  height: 5.0.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

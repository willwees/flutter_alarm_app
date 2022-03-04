import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/constants/app_colors.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        children: <Widget>[
          _buildBodyClock(),
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
}

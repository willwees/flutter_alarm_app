import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/blocs/home/home_bloc.dart';
import 'package:flutter_alarm_app/src/constants/device_properties.dart';
import 'package:flutter_alarm_app/src/widgets/clock_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    _setConstants(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm App'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: _homeBloc,
            builder: (_, HomeState state) {
              return ClockWidget(
                hours: state.hours,
                minutes: state.minutes,
                seconds: state.seconds,
                onHourPanUpdate: (int newHours) =>
                    _homeBloc.add(HomeSetClockEvent(clockType: ClockType.hours, newValue: newHours)),
                onMinutesPanUpdate: (int newMinutes) =>
                    _homeBloc.add(HomeSetClockEvent(clockType: ClockType.minutes, newValue: newMinutes)),
                onSecondsPanUpdate: (int newSeconds) =>
                    _homeBloc.add(HomeSetClockEvent(clockType: ClockType.seconds, newValue: newSeconds)),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Set initial constants
  void _setConstants(BuildContext context) {
    kDeviceSize = MediaQuery.of(context).size;
    kDeviceLogicalWidth = MediaQuery.of(context).size.width;
    kDeviceLogicalHeight = MediaQuery.of(context).size.height;
    kDevicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    kDevicePhysicalWidth = kDeviceLogicalWidth * kDevicePixelRatio;
    kDevicePhysicalHeight = kDeviceLogicalHeight * kDevicePixelRatio;
  }
}

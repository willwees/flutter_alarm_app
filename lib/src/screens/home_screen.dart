import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/blocs/home/home_bloc.dart';
import 'package:flutter_alarm_app/src/constants/device_properties.dart';
import 'package:flutter_alarm_app/src/utils/notification_service.dart';
import 'package:flutter_alarm_app/src/widgets/clock_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationService _notificationService = NotificationService();
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
          child: BlocConsumer<HomeBloc, HomeState>(
            bloc: _homeBloc,
            listenWhen: (HomeState previous, HomeState current) => previous.isSaved != current.isSaved,
            listener: (BuildContext context, HomeState state) {
              if (state.isSaved) {
                _notificationService.scheduleNotifications(
                  title: 'Alarm triggered!',
                  body: 'h: ${state.hours}, m: ${state.minutes}, s: ${state.seconds}',
                  payload: '/detail',
                );
              }
            },
            builder: (_, HomeState state) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 24.0.w),
                  // Clock
                  ClockWidget(
                    hours: state.hours,
                    minutes: state.minutes,
                    seconds: state.seconds,
                    onHourPanUpdate: (int newHours) =>
                        _homeBloc.add(HomeUpdateClockEvent(clockType: ClockType.hours, newValue: newHours)),
                    onMinutesPanUpdate: (int newMinutes) =>
                        _homeBloc.add(HomeUpdateClockEvent(clockType: ClockType.minutes, newValue: newMinutes)),
                    onSecondsPanUpdate: (int newSeconds) =>
                        _homeBloc.add(HomeUpdateClockEvent(clockType: ClockType.seconds, newValue: newSeconds)),
                  ),
                  SizedBox(height: 24.0.w),
                  // Save Button
                  ElevatedButton(
                    onPressed: () => _homeBloc.add(HomeSaveAlarmEvent()),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20.0.w),
                      child: const Text('Save'),
                    ),
                  ),
                ],
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

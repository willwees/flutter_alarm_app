import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/blocs/home/home_bloc.dart';
import 'package:flutter_alarm_app/src/constants/device_properties.dart';
import 'package:flutter_alarm_app/src/utils/date_helper.dart';
import 'package:flutter_alarm_app/src/utils/notification_helper.dart';
import 'package:flutter_alarm_app/src/widgets/home/clock_mode_widget.dart';
import 'package:flutter_alarm_app/src/widgets/home/clock_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _notificationHelper.runNotificationAfterAppIsTerminated();
  }

  @override
  Widget build(BuildContext context) {
    _setConstants(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm App'),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listenWhen: (HomeState previous, HomeState current) => previous.isSaved != current.isSaved,
        listener: (BuildContext context, HomeState state) {
          if (state.isSaved) {
            _notificationHelper.scheduleNotifications(
              title: 'Alarm triggered!',
              body: 'Alarm triggered at ${DateHelper.dateTimeToString(state.alarmDateTime!)}',
              dateTime: state.alarmDateTime!,
              payload: jsonEncode(state.notificationPayloadModel!.toJson()), // encode the payload to json
            );

            // show snackbar
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    'Alarm scheduled for ${DateHelper.dateTimeToString(state.alarmDateTime!)}',
                  ),
                ),
              );
          }
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildClockModeSection(),
                SizedBox(height: 48.0.w),
                _buildMainClockSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildSaveButton(),
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

  Widget _buildClockModeSection() {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _homeBloc,
      buildWhen: (HomeState previous, HomeState current) => previous.clockMode != current.clockMode,
      builder: (_, HomeState state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // AM
            ClockModeWidget(
              onTap: () => _homeBloc.add(const HomeChangeClockModeEvent(clockMode: ClockMode.modeAM)),
              clockMode: ClockMode.modeAM,
              activeClockMode: state.clockMode,
            ),
            // PM
            ClockModeWidget(
              onTap: () => _homeBloc.add(const HomeChangeClockModeEvent(clockMode: ClockMode.modePM)),
              clockMode: ClockMode.modePM,
              activeClockMode: state.clockMode,
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainClockSection() {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _homeBloc,
      buildWhen: (HomeState previous, HomeState current) =>
          previous.hours != current.hours || previous.minutes != current.minutes || previous.seconds != current.seconds,
      builder: (_, HomeState state) {
        return ClockWidget(
          hours: state.hours,
          minutes: state.minutes,
          seconds: state.seconds,
          onHourPanUpdate: (int newHours) =>
              _homeBloc.add(HomeUpdateClockEvent(clockType: ClockType.hours, newValue: newHours)),
          onMinutesPanUpdate: (int newMinutes) =>
              _homeBloc.add(HomeUpdateClockEvent(clockType: ClockType.minutes, newValue: newMinutes)),
          onSecondsPanUpdate: (int newSeconds) =>
              _homeBloc.add(HomeUpdateClockEvent(clockType: ClockType.seconds, newValue: newSeconds)),
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
      ),
    );
  }
}

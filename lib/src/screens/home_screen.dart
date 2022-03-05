import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/blocs/home/home_bloc.dart';
import 'package:flutter_alarm_app/src/constants/device_properties.dart';
import 'package:flutter_alarm_app/src/utils/notification_service.dart';
import 'package:flutter_alarm_app/src/widgets/clock_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
      body: BlocListener<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listenWhen: (HomeState previous, HomeState current) => previous.isSaved != current.isSaved,
        listener: (BuildContext context, HomeState state) {
          if (state.isSaved) {
            _notificationService.scheduleNotifications(
              title: 'Alarm triggered!',
              body: 'Alarm triggered at ${DateFormat('dd MMM yyyy hh:mm:ss a').format(state.alarmDateTime.toLocal())}',
              dateTime: state.alarmDateTime,
              payload: '/detail',
            );

            // show snackbar
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    'Alarm scheduled for ${DateFormat('dd MMM yyyy hh:mm:ss a').format(state.alarmDateTime.toLocal())}',
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
                BlocBuilder<HomeBloc, HomeState>(
                  bloc: _homeBloc,
                  buildWhen: (HomeState previous, HomeState current) => previous.clockMode != current.clockMode,
                  builder: (_, HomeState state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () => _homeBloc.add(const HomeChangeClockModeEvent(clockMode: ClockMode.modeAM)),
                          child: Container(
                            padding: EdgeInsets.all(8.0.w),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2.0),
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(14.0.r)),
                              color: state.clockMode == ClockMode.modeAM ? Colors.green : null,
                            ),
                            child: Text(
                              'AM',
                              style: TextStyle(
                                fontSize: 40.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => _homeBloc.add(const HomeChangeClockModeEvent(clockMode: ClockMode.modePM)),
                          child: Container(
                            padding: EdgeInsets.all(8.0.w),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2.0),
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(14.0.r)),
                              color: state.clockMode == ClockMode.modePM ? Colors.green : null,
                            ),
                            child: Text(
                              'PM',
                              style: TextStyle(
                                fontSize: 40.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 48.0.w),
                BlocBuilder<HomeBloc, HomeState>(
                  bloc: _homeBloc,
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
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
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

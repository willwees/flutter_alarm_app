import 'package:equatable/equatable.dart';
import 'package:flutter_alarm_app/src/models/notification_payload_model.dart';
import 'package:flutter_alarm_app/src/utils/date_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeUpdateClockEvent>(_updateClock);
    on<HomeSaveAlarmEvent>(_saveAlarm);
    on<HomeChangeClockModeEvent>(_changeClockMode);
  }

  /// Called on [HomeUpdateClockEvent]
  void _updateClock(HomeUpdateClockEvent event, Emitter<HomeState> emit) {
    switch (event.clockType) {
      case ClockType.hours:
        if (state.clockMode == ClockMode.modeAM) {
          // mode AM
          emit(state.copyWith(hours: event.newValue));
        } else {
          // mode PM
          emit(state.copyWith(hours: event.newValue + 12));
        }
        break;
      case ClockType.minutes:
        if (state.minutes <= 1 && event.newValue >= 59) {
          // we need to set hours to hours-1, if we pan the minutes hand CCW.
          final int hours = state.hours - 1 < 0 ? state.hours - 1 + 12 : state.hours - 1;
          emit(state.copyWith(hours: hours, minutes: event.newValue));
        } else if (state.minutes >= 59 && event.newValue <= 1) {
          // we need to set hours to hours+1, if we pan the minutes hand CW.
          final int hours = state.hours + 1 >= 12 ? state.hours + 1 - 12 : state.hours + 1;
          emit(state.copyWith(hours: hours, minutes: event.newValue));
        } else {
          emit(state.copyWith(minutes: event.newValue));
        }
        break;
      case ClockType.seconds:
        emit(state.copyWith(seconds: event.newValue));
        break;
    }
  }

  /// Called on [HomeSaveAlarmEvent]
  void _saveAlarm(HomeSaveAlarmEvent event, Emitter<HomeState> emit) {
    final DateTime alarmDateTime = DateHelper.getAlarmDateTime(state.hours, state.minutes, state.seconds);

    emit(
      state.copyWith(
        isSaved: true,
        alarmDateTime: alarmDateTime,
        notificationPayloadModel: NotificationPayloadModel(
          path: '/detail',
          alarmDateTimeString: alarmDateTime.toString(),
        ),
      ),
    );

    // reset to false
    emit(state.copyWith(isSaved: false));
  }

  /// Called on [HomeChangeClockModeEvent]
  void _changeClockMode(HomeChangeClockModeEvent event, Emitter<HomeState> emit) {
    // discard if it is the same event
    if (state.clockMode == event.clockMode) {
      return;
    }

    late final int newHours;
    if (event.clockMode == ClockMode.modeAM) {
      newHours = state.hours - 12;
    } else {
      newHours = state.hours + 12;
    }

    emit(
      state.copyWith(
        clockMode: event.clockMode,
        hours: newHours,
      ),
    );
  }
}

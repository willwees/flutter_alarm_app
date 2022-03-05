import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(alarmDateTime: DateTime(1900))) {
    on<HomeUpdateClockEvent>(_setClock);
    on<HomeSaveAlarmEvent>(_saveAlarm);
  }

  void _setClock(HomeUpdateClockEvent event, Emitter<HomeState> emit) {
    switch (event.clockType) {
      case ClockType.hours:
        emit(state.copyWith(hours: event.newValue));
        break;
      case ClockType.minutes:
        emit(state.copyWith(minutes: event.newValue));
        break;
      case ClockType.seconds:
        emit(state.copyWith(seconds: event.newValue));
        break;
    }
  }

  void _saveAlarm(HomeSaveAlarmEvent event, Emitter<HomeState> emit) {
    final DateTime alarmDateTime = _getAlarmDateTime(state.hours, state.minutes, state.seconds);

    emit(state.copyWith(isSaved: true, alarmDateTime: alarmDateTime));

    // reset to false
    emit(state.copyWith(isSaved: false));
  }

  DateTime _getAlarmDateTime(int hours, int minutes, int seconds) {
    final DateTime now = DateTime.now();
    final DateTime alarm = DateTime(now.year, now.month, now.day, hours, minutes, seconds);

    // if alarm is before now, set to tomorrow
    if (alarm.isBefore(now)) {
      return alarm.add(const Duration(days: 1));
    }

    return alarm;
  }
}

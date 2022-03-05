import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
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
    emit(state.copyWith(isSaved: true));

    // reset to false
    emit(state.copyWith(isSaved: false));
  }
}

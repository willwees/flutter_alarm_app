part of 'home_bloc.dart';

enum ClockType { hours, minutes, seconds }

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => <Object>[];
}

class HomeUpdateClockEvent extends HomeEvent {
  final ClockType clockType;
  final int newValue;

  const HomeUpdateClockEvent({
    required this.clockType,
    required this.newValue,
  });

  @override
  List<Object?> get props => <Object>[clockType, newValue];
}

class HomeSaveAlarmEvent extends HomeEvent {}

class HomeChangeClockModeEvent extends HomeEvent {
  final ClockMode clockMode;

  const HomeChangeClockModeEvent({
    required this.clockMode,
  });

  @override
  List<Object?> get props => <Object>[clockMode];
}

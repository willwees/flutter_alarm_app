part of 'home_bloc.dart';

enum ClockType { hours, minutes, seconds }

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeSetClockEvent extends HomeEvent {
  final ClockType clockType;
  final int newValue;

  const HomeSetClockEvent({
    required this.clockType,
    required this.newValue,
  });

  @override
  List<Object?> get props => <Object>[];
}

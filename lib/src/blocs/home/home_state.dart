part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int hours;
  final int minutes;
  final int seconds;

  const HomeState({
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
  });

  HomeState copyWith({
    int? hours,
    int? minutes,
    int? seconds,
  }) {
    return HomeState(
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
    );
  }

  @override
  List<Object> get props => <Object>[
        hours,
        minutes,
        seconds,
      ];

  @override
  String toString() {
    return 'HomeState { '
        'hours: $hours, '
        'minutes: $minutes, '
        'seconds: $seconds, '
        '}';
  }
}

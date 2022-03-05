part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int hours;
  final int minutes;
  final int seconds;
  final bool isSaved;

  const HomeState({
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.isSaved = false,
  });

  HomeState copyWith({
    int? hours,
    int? minutes,
    int? seconds,
    bool? isSaved,
  }) {
    return HomeState(
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object> get props => <Object>[
        hours,
        minutes,
        seconds,
        isSaved,
      ];

  @override
  String toString() {
    return 'HomeState { '
        'hours: $hours, '
        'minutes: $minutes, '
        'seconds: $seconds, '
        'isSaved: $isSaved, '
        '}';
  }
}

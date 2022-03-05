part of 'home_bloc.dart';

enum ClockMode { modeAM, modePM }

class HomeState extends Equatable {
  final int hours;
  final int minutes;
  final int seconds;
  final DateTime? alarmDateTime;
  final bool isSaved;
  final NotificationPayloadModel? notificationPayloadModel;
  final ClockMode clockMode;

  const HomeState({
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.alarmDateTime,
    this.notificationPayloadModel,
    this.isSaved = false,
    this.clockMode = ClockMode.modeAM,
  });

  HomeState copyWith({
    int? hours,
    int? minutes,
    int? seconds,
    DateTime? alarmDateTime,
    NotificationPayloadModel? notificationPayloadModel,
    bool? isSaved,
    ClockMode? clockMode,
  }) {
    return HomeState(
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      alarmDateTime: alarmDateTime ?? this.alarmDateTime,
      notificationPayloadModel: notificationPayloadModel ?? this.notificationPayloadModel,
      isSaved: isSaved ?? this.isSaved,
      clockMode: clockMode ?? this.clockMode,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        hours,
        minutes,
        seconds,
        alarmDateTime,
        notificationPayloadModel,
        isSaved,
        clockMode,
      ];

  @override
  String toString() {
    return 'HomeState { '
        'hours: $hours, '
        'minutes: $minutes, '
        'seconds: $seconds, '
        'alarmDateTime: $alarmDateTime, \n'
        'notificationPayloadModel: $notificationPayloadModel, \n'
        'isSaved: $isSaved, '
        'clockMode: $clockMode, '
        '}';
  }
}

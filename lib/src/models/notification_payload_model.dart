class NotificationPayloadModel {
  late final String path;
  late final String alarmDateTimeString;

  NotificationPayloadModel({
    required this.path,
    required this.alarmDateTimeString,
  });

  NotificationPayloadModel.fromJson(Map<String, dynamic> json) {
    path = json['path'] as String;
    alarmDateTimeString = json['alarmDateTimeString'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['alarmDateTimeString'] = alarmDateTimeString;
    return data;
  }
}

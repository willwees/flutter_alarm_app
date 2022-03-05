import 'package:intl/intl.dart';

class DateHelper {
  /// Return alarm DateTime from the selected time
  static DateTime getAlarmDateTime(int hours, int minutes, int seconds) {
    final DateTime now = DateTime.now();
    final DateTime alarm = DateTime(now.year, now.month, now.day, hours, minutes, seconds);

    // if alarm is before now, set to tomorrow
    if (alarm.isBefore(now)) {
      return alarm.add(const Duration(days: 1));
    }

    return alarm;
  }

  /// Format: dd MMM yyyy hh:mm:ss a
  static String dateTimeToString(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('dd MMM yyyy hh:mm:ss a');
    final String dateString = dateFormat.format(dateTime.toLocal());
    return dateString;
  }

  /// Convert number to thousand separator
  static String numberToThousandSeparatorFormat(num number) {
    final String _formattedNumber = NumberFormat('#,###').format(number);
    return _formattedNumber;
  }
}

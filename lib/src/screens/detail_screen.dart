import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/utils/date_helper.dart';
import 'package:flutter_alarm_app/src/widgets/detail/bar_chart_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  final String? arguments;

  const DetailScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final DateTime _alarmDateTime;
  late final int _alarmDiffSeconds;

  @override
  void initState() {
    super.initState();
    _alarmDateTime = widget.arguments != null ? DateTime.parse(widget.arguments!) : DateTime(1900);
    _alarmDiffSeconds = DateTime.now().difference(_alarmDateTime).inSeconds;
    debugPrint('_alarmDateTime: $_alarmDateTime');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Details'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Alarm At: ${DateHelper.dateTimeToString(_alarmDateTime)}'),
              Text('Now: ${DateHelper.dateTimeToString(DateTime.now())}'),
              Text('Diff seconds: $_alarmDiffSeconds'),
              SizedBox(height: 100.0.w),
              BarChartWidget(
                alarmDateTime: _alarmDateTime,
                alarmDiffSeconds: _alarmDiffSeconds,
                alarmMaxDiffSeconds: _alarmDiffSeconds,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

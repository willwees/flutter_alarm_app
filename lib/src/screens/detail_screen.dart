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
  late final DateTime _now;
  late final int _alarmDiffSeconds;

  @override
  void initState() {
    super.initState();
    _alarmDateTime = widget.arguments != null ? DateTime.parse(widget.arguments!) : DateTime(1900);
    _now = DateTime.now();
    _alarmDiffSeconds = _now.difference(_alarmDateTime).inSeconds;
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
              _buildTableSection(),
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

  Widget _buildTableSection() {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FractionColumnWidth(0.4),
        1: FractionColumnWidth(0.6),
      },
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            const Text(
              'Alarm triggered at: ',
              textAlign: TextAlign.end,
            ),
            Text(' ${DateHelper.dateTimeToString(_alarmDateTime)}'),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Text(
              'Now: ',
              textAlign: TextAlign.end,
            ),
            Text(' ${DateHelper.dateTimeToString(_now)}'),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Text(
              'Diff: ',
              textAlign: TextAlign.end,
            ),
            Text(' ${DateHelper.numberToThousandSeparatorFormat(_alarmDiffSeconds)} seconds'),
          ],
        ),
      ],
    );
  }
}

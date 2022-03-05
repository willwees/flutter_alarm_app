import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/utils/date_helper.dart';

class DetailScreen extends StatefulWidget {
  final String? arguments;

  const DetailScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final String? _dateTimeString;

  @override
  void initState() {
    super.initState();
    _dateTimeString = widget.arguments;
    debugPrint('dateTimeString: $_dateTimeString');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm App'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            if (_dateTimeString != null)
              Text('Alarm At: ${DateHelper.dateTimeToString(DateTime.parse(_dateTimeString!))}'),
            Text('Now: ${DateHelper.dateTimeToString(DateTime.now())}'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/utils/date_helper.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? dateTimeString = ModalRoute.of(context)?.settings.arguments as String?;
    print('dateTimeString: $dateTimeString');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm App'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            if (dateTimeString != null)
              Text('Alarm At: ${DateHelper.dateTimeToString(DateTime.parse(dateTimeString))}'),
            Text('Now: ${DateHelper.dateTimeToString(DateTime.now())}'),
          ],
        ),
      ),
    );
  }
}

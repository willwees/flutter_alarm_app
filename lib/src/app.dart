import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/src/screens/detail_screen.dart';
import 'package:flutter_alarm_app/src/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: () => MaterialApp(
        title: 'Flutter Alarm App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: navigatorKey,
        initialRoute: '/detail',
        routes: <String, Widget Function(BuildContext)>{
          '/': (BuildContext context) => const HomeScreen(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if(settings.name == '/detail'){
            final String? arguments = settings.arguments as String?;
            return MaterialPageRoute<dynamic>(builder: (BuildContext context) => DetailScreen(arguments: arguments));
          }
        },
      ),
    );
  }
}

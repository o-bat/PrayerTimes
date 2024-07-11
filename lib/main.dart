import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times/Components/alarm.dart';


import 'package:prayer_times/models/model_calendar_daily.dart';
import 'package:prayer_times/pages/prayer_times.dart';
import 'package:prayer_times/pages/settings.dart';
import 'package:prayer_times/pages/splash_screen.dart';
import 'package:prayer_times/pages/statistics.dart';
import 'package:prayer_times/pages/tesbihat_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Alarm.init();
  runApp( SplashScreen());
}

class MyApp extends StatefulWidget {
  AsyncSnapshot<CalendarDaily> snapshot;

  MyApp({super.key, required this.snapshot});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
            theme: ThemeData(
                colorSchemeSeed: lightDynamic?.primary,
                brightness: Brightness.light),
            darkTheme: ThemeData(
                colorSchemeSeed: darkDynamic?.primary,
                brightness: Brightness.dark),
            home: Naviagte(
              snapshot: widget.snapshot,
            ));
      },
    );
  }
}

class Naviagte extends StatefulWidget {
  AsyncSnapshot<CalendarDaily> snapshot;
  Naviagte({super.key, required this.snapshot});

  @override
  State<Naviagte> createState() => _NaviagteState();
}

class _NaviagteState extends State<Naviagte> {
  late List<AlarmSettings> alarms;

  static StreamSubscription<AlarmSettings>? subscription;
  @override
  void initState() {
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
    super.initState();
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>  AlarmPage(
              settings: alarmSettings,
              )),
    );

    loadAlarms();
  }

  void loadAlarms() {
    if(mounted){
      setState(() {
        alarms = Alarm.getAlarms();
        alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
      });
    }
  }

  int currentPage = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.book_outlined),
                selectedIcon: Icon(Icons.book),
                label: "Tesbihat"),
            NavigationDestination(
                icon: Icon(Icons.timelapse_outlined),
                selectedIcon: Icon(Icons.timelapse_rounded),
                label: "Namaz vakitleri"),
            NavigationDestination(
                icon: Icon(Icons.insert_chart_outlined_sharp),
                selectedIcon: Icon(Icons.insert_chart),
                label: "Statistics"),
            NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: "Settings"),
          ],
          selectedIndex: currentPage,
          onDestinationSelected: (value) {
            setState(() {
              currentPage = value;
            });
          },
        ),
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () async {}, icon: const Icon(Icons.search))
          ],
          title: const Text("Prayer Times"),
        ),
        body: currentPage == 0
            ? const Tesbihhat()
            : currentPage == 1
                ? PrayerTimes(
                    snapshot: widget.snapshot,
                  )
                : currentPage == 2
                    ? const Statistics()
                    : Settings(
                        snapshot: widget.snapshot,
                      ));
  }
}

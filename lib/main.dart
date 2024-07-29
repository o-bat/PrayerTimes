import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_times/Components/alarm.dart';
import 'package:prayer_times/Components/components.dart';
import 'package:prayer_times/Components/provider.dart';

import 'package:prayer_times/models/model_calendar_daily.dart';
import 'package:prayer_times/pages/prayer_times.dart';
import 'package:prayer_times/pages/search_page.dart';
import 'package:prayer_times/pages/settings.dart';
import 'package:prayer_times/pages/splash_screen.dart';
import 'package:prayer_times/pages/statistics.dart';
import 'package:prayer_times/pages/tesbihat_menu.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Alarm.init();
  runApp(const SplashScreen());
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
          builder: (context) => AlarmPage(
                settings: alarmSettings,
              )),
    );

    loadAlarms();
  }

  void loadAlarms() {
    if (mounted) {
      setState(() {
        alarms = Alarm.getAlarms();
        alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
      });
    }
  }

  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String day = DateFormat('EEEE').format(date).toString();

    return Scaffold(
        floatingActionButton: currentPage == 2
            ? FloatingActionButton(
                onPressed: () {
                  int rakat = day == "Monday"
                      ? Provider.of<StatisticsProvider>(context, listen: false)
                          .monday
                      : day == "Tuesday"
                          ? Provider.of<StatisticsProvider>(context,
                                  listen: false)
                              .tuesday
                          : day == "Wednesday"
                              ? Provider.of<StatisticsProvider>(context,
                                      listen: false)
                                  .wednesday
                              : day == "Thursday"
                                  ? Provider.of<StatisticsProvider>(context,
                                          listen: false)
                                      .thursday
                                  : day == "Friday"
                                      ? Provider.of<StatisticsProvider>(context,
                                              listen: false)
                                          .friday
                                      : day == "Saturday"
                                          ? Provider.of<StatisticsProvider>(
                                                  context,
                                                  listen: false)
                                              .saturday
                                          : Provider.of<StatisticsProvider>(
                                                  context,
                                                  listen: false)
                                              .sunday;
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Add Rakat"),
                            Center(
                              child: Transform.scale(
                                scale: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            rakat--;

                                            Provider.of<StatisticsProvider>(
                                                    context,
                                                    listen: false)
                                                .changeValue(rakat);
                                          });
                                        },
                                        icon: const Icon(Icons.remove)),
                                    Text(rakat.toString()),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            rakat++;
                                            Provider.of<StatisticsProvider>(
                                                    context,
                                                    listen: false)
                                                .changeValue(rakat);
                                          });
                                        },
                                        icon: const Icon(Icons.add)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.book_outlined),
                selectedIcon: Icon(Icons.book),
                label: "Tesbihat"),
            NavigationDestination(
                icon: Icon(Icons.timelapse_outlined),
                selectedIcon: Icon(Icons.timelapse_rounded),
                label: "Prayer Times"),
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
            IconButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ));
                },
                icon: const Hero(tag: "0", child: Icon(Icons.search)))
          ],
          title: const Text("Prayer Times"),
        ),
        body: currentPage == 0
            ? const Tesbihhat()
            : currentPage == 1
                ? PrayerTimes(
                    snapshot: widget.snapshot,
                  )
                : Settings(
                    snapshot: widget.snapshot,
                  ));
  }
}

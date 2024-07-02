import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'package:prayer_times/models/model_calendar_daily.dart';
import 'package:prayer_times/pages/prayer_times.dart';
import 'package:prayer_times/pages/settings.dart';
import 'package:prayer_times/pages/splash_screen.dart';
import 'package:prayer_times/pages/tesbihat_menu.dart';

void main() {
  runApp(const SplashScreen());
}

class MyApp extends StatefulWidget {
  AsyncSnapshot<CalendarDaily> snapshot;
  MyApp({super.key, required this.snapshot});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 1;
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
          home: Scaffold(
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
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: "Tesbihat"),
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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                ],
                title: const Text("Prayer Times"),
              ),
              body: currentPage == 0
                  ? const Tesbihhat()
                  : currentPage == 1
                      ? PrayerTimes(
                          snapshot: widget.snapshot,
                        )
                      : const Settings()),
        );
      },
    );
  }
}

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prayer_times/Components/provider.dart';
import 'package:prayer_times/main.dart';
import 'package:prayer_times/models/model_calendar_daily.dart';
import 'package:prayer_times/services/http.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              CMethodProvider(selected: "Diyanet İşleri Başkanliği, Turkey"),
        ),
        ChangeNotifierProvider(
          create: (context) => AlarmSettingsProvider(
            selected: "Notification Sound",
            fajrAlarm: true,
            dhuhrAlarm: true,
            asrAlarm: true,
            maghribAlarm: true,
            ishaAlarm: true,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => StatisticsProvider(),
        ),
      ],
      builder: (context, child) {
        return Consumer<CMethodProvider>(
          builder: (context, value, child) {
            return FutureBuilder(
              future: getCalendarDaily(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return DynamicColorBuilder(
                    builder: (lightDynamic, darkDynamic) {
                      return MaterialApp(
                        theme: ThemeData(
                          colorSchemeSeed: lightDynamic?.primary,
                          brightness: Brightness.light,
                        ),
                        darkTheme: ThemeData(
                          colorSchemeSeed: darkDynamic?.primary,
                          brightness: Brightness.dark,
                        ),
                        home: Scaffold(
                          body: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Image.asset("assets/icon/ic_launcher.png"),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  // Handle the error case, you can show an error message or retry button
                  return MaterialApp(
                    home: Scaffold(
                      body: Center(
                        child: Text('An error occurred: ${snapshot.error}'),
                      ),
                    ),
                  );
                } else {
                  // Stop any previous alarms
                  for (int i = 1; i <= 5; i++) {
                    Alarm.stop(i);
                  }

                  // Initialize alarms for the prayer times
                  initAlarms(
                      snapshot, Provider.of<AlarmSettingsProvider>(context));

                  return MyApp(snapshot: snapshot);
                }
              },
            );
          },
        );
      },
    );
  }

  Future<void> initAlarms(AsyncSnapshot<CalendarDaily> snapshot,
      AlarmSettingsProvider provider) async {
    final status = await Permission.notification.status;

    // If permission is not granted, request it
    if (status.isGranted) {
      final result = await Permission.notification.request();
      if (!result.isGranted) return;
    }

    final now = DateTime.now();
    final alarmSettings = provider;
    final timings = snapshot.data?.data?.timings;

    

    final prayerTimes = [
      ('Fajr', timings?.fajr, alarmSettings.fajrAlarm),
      ('Dhuhr', timings?.dhuhr, alarmSettings.dhuhrAlarm),
      ('Asr', timings?.asr, alarmSettings.asrAlarm),
      ('Maghrib', timings?.maghrib, alarmSettings.maghribAlarm),
      ('Isha', timings?.isha, alarmSettings.ishaAlarm),
    ];

    for (var i = 0; i < prayerTimes.length; i++) {
      final (name, time, isAlarmOn) = prayerTimes[i];
      if (time == null || !isAlarmOn) continue;

      final prayerTime = _parseDateTime(now, time);
      if (now.isBefore(prayerTime) && status.isGranted) {
        await setAlarms(time, name, i + 1, alarmSettings);
        log("Alarm set for $name");
      }
    }
  }

  DateTime _parseDateTime(DateTime now, String time) {
    return DateTime.parse(
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} $time:00.000000");
  }

  Future<void> setAlarms(String timeString, String timeLabel, int id,
      AlarmSettingsProvider alarmSettingsProvider) async {
    // Use DateFormat.Hm() for parsing time in "HH:mm" format
    final timeFormat = DateFormat.Hm();

    // Parse the time string, handling potential errors
    DateTime? parsedTime;
    try {
      parsedTime = timeFormat.parse(timeString);
    } catch (e) {
      // Handle parsing errors, e.g., show an error message to the user
      log('Error parsing time: $e');
      return; // Exit the function if parsing fails
    }

    final now = DateTime.now();
    final alarmDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
    );

    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: alarmDateTime,
      assetAudioPath: alarmSettingsProvider.number == 0
          ? 'assets/alarm.mp3'
          : 'assets/adhan.mp3',
      loopAudio: true,
      vibrate: true,
      fadeDuration: 1.0,
      notificationTitle: timeLabel,
      notificationBody: 'It is time for $timeLabel',
      enableNotificationOnKill: Platform.isIOS,
    );

    // Use await to handle the asynchronous operation
    await Alarm.set(alarmSettings: alarmSettings);
  }
}

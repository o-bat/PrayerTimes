import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_times/Components/provider.dart';
import 'package:prayer_times/pages/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:slidable_button/slidable_button.dart';

class AlarmPage extends StatefulWidget {
  AlarmSettings settings;
  AlarmPage({super.key, required this.settings});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  //TODO Never Gonna Give You Up ekle sadece Selma Icion
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Transform.scale(
            scale: 2,
            child: Text(
              widget.settings.notificationTitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const Spacer(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Transform.scale(
                    scale: 2,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: HorizontalSlidableButton(
                        initialPosition: SlidableButtonPosition.center,
                        buttonWidth: 60.0,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                        buttonColor: Theme.of(context).primaryColor,
                        dismissible: false,
                        label: const Center(child: Icon(Icons.alarm)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Remind'),
                              Text('Stop'),
                            ],
                          ),
                        ),
                        onChanged: (position) {
                          setState(() {
                            if (position == SlidableButtonPosition.end) {
                              Alarm.stop(widget.settings.id);
                              Navigator.pop(context);
                            } else {
                              DateTime currentTime = DateTime.now();

                              // Add 10 minutes to the current time
                              Duration add10Minutes =
                                  const Duration(minutes: 10);
                              DateTime newTime = currentTime.add(add10Minutes);
                              setAlarms(
                                  "${newTime.hour}:${newTime.minute}'",
                                  " ${widget.settings.notificationTitle}c",
                                  widget.settings.id + 5,
                                  context.watch<AlarmSettingsProvider>());
                              Alarm.stop(widget.settings.id);
                              Navigator.pop(context);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const Spacer()
        ],
      ),
    );
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
      print('Error parsing time: $e');
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

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times/pages/splash_screen.dart';
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
          Spacer(),
          Transform.scale(
            scale: 2,
            child: Text(
              widget.settings.notificationTitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Spacer(),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(18.0),
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
                        label: Center(child: Icon(Icons.alarm)),
                        child: Padding(
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
                              Duration add10Minutes = Duration(minutes: 10);
                              DateTime newTime = currentTime.add(add10Minutes);
                              setAlarms(
                                  "${newTime.hour}:${newTime.minute}'",
                                  " ${widget.settings.notificationTitle}c",
                                  widget.settings.id + 5,
                                  context);
                              Alarm.stop(widget.settings.id);
                              Navigator.pop(context);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}

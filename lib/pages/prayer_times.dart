import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prayer_times/models/model_calendar_daily.dart';
import 'package:prayer_times/services/http.dart';

class PrayerTimes extends StatefulWidget {
  const PrayerTimes({super.key});

  @override
  State<PrayerTimes> createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes> {
  Stream<String> _clockStream() async* {
    while (true) {
      yield _formatDateTime(DateTime.now());
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: getCalendarDaily(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StreamBuilder<String>(
                stream: _clockStream(),
                builder: (context, snapshot0) {
                  if (snapshot0.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Current Time",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "Time Left",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      snapshot0.data ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text("Fajr"),
                            trailing: Text(snapshot.data!.data.timings.fajr),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text("Sunrise"),
                            trailing: Text(snapshot.data!.data.timings.sunrise),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text("Dhuhr"),
                            trailing: Text(snapshot.data!.data.timings.dhuhr),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text("Sunset"),
                            trailing: Text(snapshot.data!.data.timings.sunset),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text("Maghrib"),
                            trailing: Text(snapshot.data!.data.timings.maghrib),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text("Isha"),
                            trailing: Text(snapshot.data!.data.timings.isha),
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

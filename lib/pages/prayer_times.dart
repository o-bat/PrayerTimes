import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prayer_times/Components/components.dart';
import 'package:prayer_times/models/model_calendar_daily.dart';

class PrayerTimes extends StatefulWidget {
  AsyncSnapshot<CalendarDaily> snapshot;
  PrayerTimes({super.key, required this.snapshot});

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
        child: StreamBuilder<String>(
          stream: _clockStream(),
          builder: (context, snapshot0) {
            if (snapshot0.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return Column(
                children: [
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Current Time",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    snapshot0.data ?? "",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    getTime(widget.snapshot, snapshot0),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    getTimeLeft(widget.snapshot, snapshot0),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      title: const Text("Fajr"),
                      trailing:
                          Text(widget.snapshot.data?.data?.timings?.fajr ?? ""),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      title: const Text("Dhuhr"),
                      trailing: Text(
                          widget.snapshot.data?.data?.timings?.dhuhr ?? ""),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      title: const Text("Asr"),
                      trailing:
                          Text(widget.snapshot.data?.data?.timings?.asr ?? ""),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      title: const Text("Maghrib"),
                      trailing: Text(
                          widget.snapshot.data?.data?.timings?.maghrib ?? ""),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      title: const Text("Isha"),
                      trailing:
                          Text(widget.snapshot.data?.data?.timings?.isha ?? ""),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 8,
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.sunny),
                                    Icon(Icons.arrow_upward)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Sunrise "),
                                    Text(widget.snapshot.data?.data?.timings
                                            ?.sunrise ??
                                        ""),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 8,
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.sunny),
                                    Icon(Icons.arrow_downward)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Sunset "),
                                    Text(widget.snapshot.data?.data?.timings
                                            ?.sunset ??
                                        ""),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      title: const Text("Midnight"),
                      trailing: Text(
                          widget.snapshot.data?.data?.timings?.midnight ?? ""),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}

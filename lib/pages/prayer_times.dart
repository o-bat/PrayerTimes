import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_times/Components/components.dart';
import 'package:prayer_times/Components/provider.dart';
import 'package:prayer_times/models/model_calendar_daily.dart';
import 'package:provider/provider.dart';

class PrayerTimes extends StatefulWidget {
  AsyncSnapshot<CalendarDaily> snapshot;
  PrayerTimes({super.key, required this.snapshot});

  @override
  State<PrayerTimes> createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes> {
  Stream<String> _clockStream() async* {
    while (true) {
      if (Provider.of<SettingsProvider>(context, listen: false).is12h) {
        yield _formatforAm(DateTime.now());
      } else {
        yield _formatDateTime(DateTime.now());
      }

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  String _formatforAm(DateTime dateTime) {
    String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());
    return tdata;
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    bool is12h = Provider.of<SettingsProvider>(context).is12h;
    final format = DateFormat('hh:mm:ss');
    String fajr12 = DateFormat("hh:mm:ss a").format(
        (format.parse("${widget.snapshot.data!.data?.timings?.fajr}:00")));
    String dhuhr12 = DateFormat("hh:mm:ss a").format(
        (format.parse("${widget.snapshot.data!.data?.timings?.dhuhr}:00")));
    String asr12 = DateFormat("hh:mm:ss a").format(
        (format.parse("${widget.snapshot.data!.data?.timings?.asr}:00")));
    String maghrib12 = DateFormat("hh:mm:ss a").format(
        (format.parse("${widget.snapshot.data!.data?.timings?.maghrib}:00")));
    String isha12 = DateFormat("hh:mm:ss a").format(
        (format.parse("${widget.snapshot.data!.data?.timings?.isha}:00")));
    String sunrise12 = DateFormat("hh:mm:ss a").format(
        (format.parse("${widget.snapshot.data!.data?.timings?.sunrise}:00")));
    String sunset12 = DateFormat("hh:mm:ss a").format(
        (format.parse("${widget.snapshot.data!.data?.timings?.sunset}:00")));
    String midnight12 = DateFormat("hh:mm:ss a").format(
        (format.parse("${widget.snapshot.data!.data?.timings?.midnight}:00")));
    return SingleChildScrollView(
      child: Padding(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text(
                                      snapshot0.data ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      "getTime(widget.snapshot, snapshot0)",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text(
                                      getTimeLeft(
                                        widget.snapshot,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
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
                        trailing: Text(is12h == true
                            ? fajr12.substring(0, 5) + fajr12.substring(8)
                            : widget.snapshot.data!.data?.timings?.fajr ?? ""),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: ListTile(
                        title: const Text("Dhuhr"),
                        trailing: Text(is12h == true
                            ? dhuhr12.substring(0, 5) + dhuhr12.substring(8)
                            : widget.snapshot.data!.data?.timings?.dhuhr ?? ""),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: ListTile(
                        title: const Text("Asr"),
                        trailing: Text(is12h == true
                            ? asr12.substring(0, 5) + asr12.substring(8)
                            : widget.snapshot.data!.data?.timings?.asr ?? ""),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: ListTile(
                        title: const Text("Maghrib"),
                        trailing: Text(is12h == true
                            ? maghrib12.substring(0, 5) + maghrib12.substring(8)
                            : widget.snapshot.data!.data?.timings?.maghrib ??
                                ""),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: ListTile(
                        title: const Text("Isha"),
                        trailing: Text(is12h == true
                            ? isha12.substring(0, 5) + isha12.substring(8)
                            : widget.snapshot.data!.data?.timings?.isha ?? ""),
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
                                      Text(is12h == true
                                          ? sunrise12.substring(0, 5) +
                                              sunrise12.substring(8)
                                          : widget.snapshot.data!.data?.timings
                                                  ?.isha ??
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
                                      Text(is12h == true
                                          ? sunset12.substring(0, 5) +
                                              sunset12.substring(8)
                                          : widget.snapshot.data!.data?.timings
                                                  ?.isha ??
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
                        trailing: Text(is12h == true
                            ? midnight12.substring(0, 5) +
                                midnight12.substring(8)
                            : widget.snapshot.data!.data?.timings?.isha ?? ""),
                      ),
                    ),
                  ],
                );
              }
            },
          )),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prayer_times/Components/components.dart';
import 'package:prayer_times/services/http.dart';

class SearchedTimes extends StatefulWidget {
  double lat;
  double lon;
  SearchedTimes({super.key, required this.lat, required this.lon});

  @override
  State<SearchedTimes> createState() => _SearchedTimesState();
}

class _SearchedTimesState extends State<SearchedTimes> {
  Stream<String> _clockStream() async* {
    while (true) {
      yield getTimeForLocation(widget.lat, widget.lon).toString();

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCalendarDailyFromLatLon(widget.lat, widget.lon, context),
      builder: (context, snapshot) {
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
                                          getTime(snapshot, snapshot0),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        Text(
                                          getTimeLeft(snapshot, snapshot0),
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
                            trailing:
                                Text(snapshot.data?.data?.timings?.fajr ?? ""),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: ListTile(
                            title: const Text("Dhuhr"),
                            trailing:
                                Text(snapshot.data?.data?.timings?.dhuhr ?? ""),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: ListTile(
                            title: const Text("Asr"),
                            trailing:
                                Text(snapshot.data?.data?.timings?.asr ?? ""),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: ListTile(
                            title: const Text("Maghrib"),
                            trailing: Text(
                                snapshot.data?.data?.timings?.maghrib ?? ""),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: ListTile(
                            title: const Text("Isha"),
                            trailing:
                                Text(snapshot.data?.data?.timings?.isha ?? ""),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.sunny),
                                          Icon(Icons.arrow_upward)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text("Sunrise "),
                                          Text(snapshot.data?.data?.timings
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.sunny),
                                          Icon(Icons.arrow_downward)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text("Sunset "),
                                          Text(snapshot.data?.data?.timings
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
                                snapshot.data?.data?.timings?.midnight ?? ""),
                          ),
                        ),
                      ],
                    );
                  }
                },
              )),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:prayer_times/Components/tesbihatlar.dart';
import 'package:prayer_times/models/model_calendar_daily.dart';

Widget buildMenuItem(
    {required String titel,
    required BuildContext context,
    required String path}) {
  return Card(
    child: ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Tesbihat(
              path: path,
              name: titel,
            ),
          ),
        );
      },
      title: Text(titel),
    ),
  );
}

String getTimeLeft(
    AsyncSnapshot<CalendarDaily> snapshot, AsyncSnapshot<String> snapshot0) {
  final format = DateFormat('hh:mm:ss');

  if (format
      .parse("${snapshot.data!.data?.timings?.fajr}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.fajr}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.sunrise}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.sunrise}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.dhuhr}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.dhuhr}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.asr}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.asr}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.sunset}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.sunset}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.maghrib}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.maghrib}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.isha}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.isha}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
  return "";
}

String getTime(
  AsyncSnapshot<CalendarDaily> snapshot,
  AsyncSnapshot<String> snapshot0,
) {
  final format = DateFormat('hh:mm:ss');

  if (format
      .parse("${snapshot.data!.data?.timings?.fajr}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Fajr";
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.sunrise}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Sunrise";
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.dhuhr}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Dhuhr";
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.asr}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Asr";
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.sunset}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Sunset";
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.maghrib}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Maghrib";
  }
  if (format
      .parse("${snapshot.data!.data?.timings?.isha}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Isha";
  }
  return "See you Tomorrow :)";
}

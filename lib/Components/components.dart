import 'dart:developer';

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

String getTimeLeft(AsyncSnapshot<CalendarDaily> snapshot) {
  final format = DateFormat('hh:mm:ss');

  String now = DateFormat("hh:mm:ss a").format(DateTime.now());
  log(now.substring(8, 11));
  String fajr = DateFormat("hh:mm:ss a")
      .format((format.parse("${snapshot.data!.data?.timings?.fajr}:00")));
  String sunrise = DateFormat("HH:mm:ss a")
      .format((format.parse("${snapshot.data!.data?.timings?.sunrise}:00")));
  String dhuhr = DateFormat("HH:mm:ss a")
      .format((format.parse("${snapshot.data!.data?.timings?.dhuhr}:00")));
  String asr = DateFormat("HH:mm:ss a")
      .format((format.parse("${snapshot.data!.data?.timings?.asr}:00")));
  String sunset = DateFormat("HH:mm:ss a")
      .format((format.parse("${snapshot.data!.data?.timings?.sunset}:00")));
  String maghrib = DateFormat("HH:mm:ss a")
      .format((format.parse("${snapshot.data!.data?.timings?.maghrib}:00")));
  String isha = DateFormat("HH:mm:ss a")
      .format((format.parse("${snapshot.data!.data?.timings?.isha}:00")));

  return "";
}

/*String getTimeLeft(
    AsyncSnapshot<CalendarDaily> snapshot, AsyncSnapshot<String> snapshot0) {
  final format = DateFormat('hh:mm:ss a');


  if (format
      .parse("${snapshot.data!.data?.timings?.fajr}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.fajr}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
 else if (format
      .parse("${snapshot.data!.data?.timings?.sunrise}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.sunrise}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
 else if (format
      .parse("${snapshot.data!.data?.timings?.dhuhr}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.dhuhr}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
else  if (format
      .parse("${snapshot.data!.data?.timings?.asr}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.asr}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
else  if (format
      .parse("${snapshot.data!.data?.timings?.sunset}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.sunset}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
else  if (format
      .parse("${snapshot.data!.data?.timings?.maghrib}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return format
        .parse("${snapshot.data!.data?.timings?.maghrib}:00")
        .difference(format.parse(snapshot0.data ?? ""))
        .toString()
        .substring(0, 7);
  }
else  if (format
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
  final format = DateFormat('hh:mm:ss a');

  if (format
      .parse(snapshot0.data ?? "")
      .isBefore(format.parse("${snapshot.data!.data?.timings?.fajr}:00"))) {

    return "Time Left to Fajr";
  }
else  if (format
      .parse("${snapshot.data!.data?.timings?.sunrise}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Sunrise";
  }
 else if (format
      .parse("${snapshot.data!.data?.timings?.dhuhr}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Dhuhr";
  }
 else if (format
      .parse("${snapshot.data!.data?.timings?.asr}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Asr";
  }
  else if (format
      .parse("${snapshot.data!.data?.timings?.sunset}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Sunset";
  }
 else if (format
      .parse("${snapshot.data!.data?.timings?.maghrib}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Maghrib";
  }
else  if (format
      .parse("${snapshot.data!.data?.timings?.isha}:00")
      .isAfter(format.parse(snapshot0.data ?? ""))) {
    return "Time Left to Isha";
  }
  return "See you Tomorrow :)";
}
*/

bool checkTime(String first, String second) {
  String firstAmPm = first.substring(8, 11);
  String secondAmPm = second.substring(8, 11);

  return false;
}

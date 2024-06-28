import 'dart:convert' as convert;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';
import 'package:prayer_times/Components/provider.dart';
import 'package:prayer_times/models/model_calendar_daily.dart';

import 'package:provider/provider.dart';

Future<CalendarDaily> getCalendarDaily(BuildContext context) async {
  // Check if location service is enabled
  var serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  // Check location permissions
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  } else if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // Get the user's location
  var location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  var lat = location.latitude;
  var lon = location.longitude;
  log(lat.toString());
  log(lon.toString());

  DateTime now = DateTime.now();
  int year = now.year;
  int month = now.month;
  int day = now.day;

  var response = await http.get(Uri.parse(
      "http://api.aladhan.com/v1/timings/$day-$month-$year?latitude=$lat&longitude=$lon&method=${Provider.of<CMethodProvider>(context, listen: false).number}"));
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    log(response.body);
  } else {
    log('Request failed with status: ${response.statusCode}.');
  }
  return calendarDailyFromJson(response.body);
}

Future<void> getLocation() async {
  // Check if location service is enabled
  var serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  // Check location permissions
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  } else if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // Get the user's location
  var location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  var lat = location.latitude;
  var lon = location.longitude;
  log(lat.toString());
  log(lon.toString());
}

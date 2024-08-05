import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prayer_times/Components/provider.dart';
import 'package:prayer_times/api_key.dart';
import 'package:prayer_times/models/adress.dart';
import 'package:prayer_times/models/model_calendar_daily.dart';
import 'package:provider/provider.dart';
import 'package:synchronized/synchronized.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

Future<String> getTimeForLocation(double latitude, double longitude) async {
  // Replace YOUR_API_KEY with your actual TimeZoneDB API key
  String apiKey = api_key;
  final url =
      'http://api.timezonedb.com/v2.1/get-time-zone?key=$apiKey&format=json&by=position&lat=$latitude&lng=$longitude';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final timestamp = data['timestamp'];
    final zoneName = data['zoneName'];

    // Create a DateTime object from the timestamp
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

    // Format the time
    final formatter = DateFormat('HH:mm:ss');
    final localTime = formatter.format(dateTime.toLocal());

    return 'The current time at ($latitude, $longitude) is $localTime $zoneName';
  } else {
    throw Exception('Failed to load timezone data');
  }
}

Future<CalendarDaily> getCalendarDaily(BuildContext context) async {
  // Check and request location permissions
  await _checkAndRequestLocationPermission();

  // Get the user's location
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  double lat = position.latitude;
  double lon = position.longitude;

  int methodNumber =
      Provider.of<CMethodProvider>(context, listen: false).number;

  DateTime now = DateTime.now();
  String url =
      'http://api.aladhan.com/v1/timings/${now.day}-${now.month}-${now.year}?latitude=$lat&longitude=$lon&method=$methodNumber';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return calendarDailyFromJson(response.body);
  } else {
    throw Exception(
        'Failed to load prayer times. Status: ${response.statusCode}');
  }
}

bool _isRequestingPermission = false;
final _permissionLock = Lock();

Future<void> _checkAndRequestLocationPermission() async {
  await _permissionLock.synchronized(() async {
    if (_isRequestingPermission) {
      // If a request is already in progress, wait for it to complete
      return;
    }

    getAutoStartPermission();

    _isRequestingPermission = true;
    try {
      if (await Permission.notification.request().isDenied) {
        openAppSettings();
      }
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    } finally {
      _isRequestingPermission = false;
    }
  });
}

Future<List<Adresses>> getSuggestion(String searchElement) async {
  String url =
      'https://nominatim.openstreetmap.org/search?q=$searchElement&format=json';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return adressesFromJson(response.body);
  } else {
    throw Exception('Failed to load adresses. Status: ${response.statusCode}');
  }
}




Future<CalendarDaily> getCalendarDailyFromLatLon(double lat, double lon, BuildContext
context) async {


  int methodNumber =
      Provider.of<CMethodProvider>(context, listen: false).number;

  DateTime now = DateTime.now();
  String url =
      'http://api.aladhan.com/v1/timings/${now.day}-${now.month}-${now.year}?latitude=$lat&longitude=$lon&method=$methodNumber';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return calendarDailyFromJson(response.body);
  } else {
    throw Exception(
        'Failed to load prayer times. Status: ${response.statusCode}');
  }
}

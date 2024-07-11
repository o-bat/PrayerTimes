import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prayer_times/Components/provider.dart';
import 'package:prayer_times/models/model_calendar_daily.dart';
import 'package:provider/provider.dart';
import 'package:synchronized/synchronized.dart';

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
      if (await Permission.scheduleExactAlarm.request().isDenied) {
        openAppSettings();
      }
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

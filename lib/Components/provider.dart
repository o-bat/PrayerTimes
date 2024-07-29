import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_times/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CMethodProvider extends ChangeNotifier {
  String selected;
  int number = 13;
  CMethodProvider({required this.selected}) {
    _loadCMethod();
  }

  void _loadCMethod() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    number = prefs.getInt('CData') ?? 13;
    notifyListeners();
    log(number.toString());
    number == 99 ? number = 6 : number = number;
  }

  void changeCMethod(
      {required String newCMethod, required List<String> list}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int index = list.indexOf(newCMethod);
      if (index == 6) {
        number == 99;
        await prefs.setInt('CData', 99);
      } else {
        number = index;
        await prefs.setInt('CData', index);
      }
      selected = newCMethod;
      notifyListeners();
      log(number.toString());
    } catch (e) {
      // Handle errors if necessary
      log('Error saving theme mode: $e');
    }
  }
}

class AlarmSettingsProvider extends ChangeNotifier {
  bool fajrAlarm;
  bool dhuhrAlarm;
  bool asrAlarm;
  bool maghribAlarm;
  bool ishaAlarm;
  String selected;
  int number = 0;

  AlarmSettingsProvider(
      {required this.fajrAlarm,
      required this.dhuhrAlarm,
      required this.asrAlarm,
      required this.maghribAlarm,
      required this.ishaAlarm,
      required this.selected}) {
    _loadCMethod();
  }

  void _loadCMethod() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    fajrAlarm = prefs.getBool('fajrAlarm') ?? true;
    dhuhrAlarm = prefs.getBool('dhuhrAlarm') ?? true;
    asrAlarm = prefs.getBool('asrAlarm') ?? true;
    maghribAlarm = prefs.getBool('maghribAlarm') ?? true;
    ishaAlarm = prefs.getBool('ishaAlarm') ?? true;
    number = prefs.getInt('SData') ?? 0;
    notifyListeners();
    log(number.toString());
    notifyListeners();
  }

  void changeSound(
      {required String newCMethod, required List<String> list}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int index = list.indexOf(newCMethod);

      number = index;
      await prefs.setInt('SData', index);

      selected = newCMethod;
      notifyListeners();
      log(number.toString());
    } catch (e) {
      // Handle errors if necessary
      log('Error saving theme mode: $e');
    }
  }

  void changefajrAlarm({
    required bool newValue,
    required String name,
  }) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log("$newValue  $name");

    prefs.setBool(name, newValue);
    fajrAlarm = newValue;
    notifyListeners();
  }

  void changeDhuhrAlarm({
    required bool newValue,
    required String name,
  }) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log("$newValue  $name");

    prefs.setBool(name, newValue);
    dhuhrAlarm = newValue;
    notifyListeners();
  }

  void changeAsrAlarm({
    required bool newValue,
    required String name,
  }) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log("$newValue  $name");

    prefs.setBool(name, newValue);
    asrAlarm = newValue;
    notifyListeners();
  }

  void changeMaghribAlarm({
    required bool newValue,
    required String name,
  }) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log("$newValue  $name");

    prefs.setBool(name, newValue);
    maghribAlarm = newValue;
    notifyListeners();
  }

  void changeIshaAlarm({
    required bool newValue,
    required String name,
  }) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log("$newValue  $name");

    prefs.setBool(name, newValue);
    ishaAlarm = newValue;
    notifyListeners();
  }
}

class StatisticsProvider extends ChangeNotifier {
  int monday = 0;
  int tuesday = 0;
  int wednesday = 0;
  int thursday = 0;
  int friday = 0;
  int saturday = 0;
  int sunday = 0;

  StatisticsProvider() {
    _loadStatistics();
  }

  void _loadStatistics() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    monday = pref.getInt("0") ?? 0;
    tuesday = pref.getInt("1") ?? 0;
    wednesday = pref.getInt("2") ?? 0;
    thursday = pref.getInt("3") ?? 0;
    friday = pref.getInt("4") ?? 0;
    saturday = pref.getInt("5") ?? 0;
    sunday = pref.getInt("6") ?? 0;

    notifyListeners();

    DateTime date = DateTime.now();
    String day = DateFormat('EEEE').format(date).toString();

    log(day);
    if (day == "Monday") {
      await pref.setInt("1", 0);
      tuesday = 0;
      await pref.setInt("2", 0);
      wednesday = 0;
      await pref.setInt("3", 0);
      thursday = 0;
      await pref.setInt("4", 0);
      friday = 0;
      await pref.setInt("5", 0);
      saturday = 0;
      await pref.setInt("6", 0);
      sunday = 0;
    }
    if (day == "Tuesday") {
      await pref.setInt("2", 0);
      wednesday = 0;
      await pref.setInt("3", 0);
      thursday = 0;
      await pref.setInt("4", 0);
      friday = 0;
      await pref.setInt("5", 0);
      saturday = 0;
      await pref.setInt("6", 0);
      sunday = 0;
    }
    if (day == "Wednesday") {
      await pref.setInt("3", 0);
      thursday = 0;
      await pref.setInt("4", 0);
      friday = 0;
      await pref.setInt("5", 0);
      saturday = 0;
      await pref.setInt("6", 0);
      sunday = 0;
    }
    if (day == "Thursday") {
      await pref.setInt("4", 0);
      friday = 0;
      await pref.setInt("5", 0);
      saturday = 0;
      await pref.setInt("6", 0);
      sunday = 0;
    }
    if (day == "Friday") {
      await pref.setInt("5", 0);
      saturday = 0;
      await pref.setInt("6", 0);
      sunday = 0;
    }
    if (day == "Saturday") {
      await pref.setInt("6", 0);
      sunday = 0;
    }
  }

  void changeValue(int newvalue) async {
    DateTime date = DateTime.now();
    String day = DateFormat('EEEE').format(date).toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log(day);
    if (day == "Monday") {
      await prefs.setInt("0", newvalue);
      monday = newvalue;
    }
    if (day == "Tuesday") {
      await prefs.setInt("1", newvalue);
      tuesday = newvalue;
    }
    if (day == "Wednesday") {
      await prefs.setInt("2", newvalue);
      wednesday = newvalue;
    }
    if (day == "Thursday") {
      await prefs.setInt("3", newvalue);
      thursday = newvalue;
    }
    if (day == "Friday") {
      await prefs.setInt("4", newvalue);
      friday = newvalue;
    }
    if (day == "Saturday") {
      await prefs.setInt("5", newvalue);
      saturday = newvalue;
    }
    if (day == "Sunday") {
      await prefs.setInt("6", newvalue);
      sunday = newvalue;
    }
    notifyListeners();
  }
}

import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
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

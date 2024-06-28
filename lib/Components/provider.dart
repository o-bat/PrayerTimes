import 'dart:developer';

import 'package:flutter/material.dart';
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


import 'package:flutter/material.dart';
import 'package:prayer_times/Components/components.dart';

class Tesbihhat extends StatelessWidget {
  const Tesbihhat({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildMenuItem(
          context: context,
          path: 'assets/sabah.txt',
          titel: 'Sabah Namazi Tasbihati',
        ),
        buildMenuItem(
            context: context,
            path: "assets/ogle.txt",
            titel: 'Ögle Namazi   Tesbihati'),
        buildMenuItem(
            context: context,
            path: 'assets/ikindi.txt',
            titel: 'Ikindi Namazi  Tesbihati'),
        buildMenuItem(
            context: context,
            path: 'assets/aksam.txt',
            titel: 'Aksam Namazi Tesbihati'),
        buildMenuItem(
            context: context,
            path: 'assets/yatsi.txt',
            titel: 'Yatsi Namazi   Tesbihati'),
      ],
    );
  }
}

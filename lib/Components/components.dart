import 'package:flutter/material.dart';
import 'package:prayer_times/Components/tesbihatlar.dart';

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

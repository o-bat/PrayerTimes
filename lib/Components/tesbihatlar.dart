import 'package:flutter/material.dart';
import 'package:flutter_text_viewer/flutter_text_viewer.dart';

class Tesbihat extends StatelessWidget {
  String path;
  String name;
  Tesbihat({super.key, required this.path, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextViewerPage(
          textViewer: TextViewer.asset(
            path,
            ignoreCase: true,
          ),
        ),
      ),
    );
  }
}

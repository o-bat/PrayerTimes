import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times/Components/provider.dart';
import 'package:prayer_times/pages/namaz_vakitleri.dart';
import 'package:prayer_times/pages/settings.dart';
import 'package:prayer_times/pages/tesbihat_menu.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CMethodProvider(selected: "Diyanet İşleri Başkanliği, Turkey (experimental)"),
        )
      ],
      child: Consumer<CMethodProvider>(
        builder: (context, value, child) {
          return DynamicColorBuilder(
            builder: (lightDynamic, darkDynamic) {
              return MaterialApp(
                theme: ThemeData(
                    colorSchemeSeed: lightDynamic?.primary,
                    brightness: Brightness.light),
                darkTheme: ThemeData(
                    colorSchemeSeed: darkDynamic?.primary,
                    brightness: Brightness.dark),
                home: Scaffold(
                    bottomNavigationBar: NavigationBar(
                      destinations: const [
                        NavigationDestination(
                            icon: Icon(Icons.book_outlined),
                            selectedIcon: Icon(Icons.book),
                            label: "Tesbihat"),
                        NavigationDestination(
                            icon: Icon(Icons.timelapse_outlined),
                            selectedIcon: Icon(Icons.timelapse_rounded),
                            label: "Namaz vakitleri"),
                        NavigationDestination(
                            icon: Icon(Icons.settings_outlined),
                            selectedIcon: Icon(Icons.settings),
                            label: "Tesbihat"),
                      ],
                      selectedIndex: currentPage,
                      onDestinationSelected: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                    ),
                    appBar: AppBar(
                      title: const Text("Prayer Timess"),
                    ),
                    body: currentPage == 0
                        ? const Tesbihhat()
                        : currentPage == 1
                            ? const NamazVakitleri()
                            : const Settings()),
              );
            },
          );
        },
      ),
    );
  }
}

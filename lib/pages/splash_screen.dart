import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times/Components/provider.dart';
import 'package:prayer_times/main.dart';
import 'package:prayer_times/services/http.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              CMethodProvider(selected: "Diyanet İşleri Başkanliği, Turkey"),
        ),
      ],
      builder: (context, child) {
        return Consumer<CMethodProvider>(
          builder: (context, value, child) {
            return FutureBuilder(
              future: getCalendarDaily(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return DynamicColorBuilder(
                    builder: (lightDynamic, darkDynamic) {
                      return MaterialApp(
                        theme: ThemeData(
                          colorSchemeSeed: lightDynamic?.primary,
                          brightness: Brightness.light,
                        ),
                        darkTheme: ThemeData(
                          colorSchemeSeed: darkDynamic?.primary,
                          brightness: Brightness.dark,
                        ),
                        home: Scaffold(
                          body: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Image.asset("assets/icon/ic_launcher.png"),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  // Handle the error case, you can show an error message or retry button
                  return MaterialApp(
                    home: Scaffold(
                      body: Center(
                        child: Text('An error occurred: ${snapshot.error}'),
                      ),
                    ),
                  );
                } else {
                  return MyApp(snapshot: snapshot);
                }
              },
            );
          },
        );
      },
    );
  }
}

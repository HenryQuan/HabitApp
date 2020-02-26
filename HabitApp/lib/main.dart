import 'Package:HabitApp/src/ui/pages/HomePage.dart';
import 'package:HabitApp/src/core/LocalData.dart';
import 'package:HabitApp/src/ui/pages/CountDownPage.dart';
import 'package:HabitApp/src/ui/pages/HabitListPage.dart';
import 'package:HabitApp/src/ui/pages/IntroPage.dart';
import 'package:HabitApp/src/ui/pages/SettingsPage.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalData().init().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Henry's Habit App",
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system,
      initialRoute: LocalData().getInitialRoute(),
      routes: {
        '/home': (context) => HomePage(),
        '/intro': (context) => IntroPage(),
        '/settings': (context) => SettingsPage(),
        '/list': (context) => HabitListPage(),
        '/timer': (context) => CountDownPage(),
      },
    );
  }
}

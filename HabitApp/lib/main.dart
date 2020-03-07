import 'Package:HabitApp/src/ui/pages/HomePage.dart';
import 'package:HabitApp/src/core/LocalData.dart';
import 'package:HabitApp/src/ui/pages/HabitListPage.dart';
import 'package:HabitApp/src/ui/pages/IntroPage.dart';
import 'package:HabitApp/src/ui/pages/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalData().init().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp() {
    // Setup notification
    final notification = FlutterLocalNotificationsPlugin();
    // TODO: remember to update the app logo
    final android = AndroidInitializationSettings('notification');
    final ios = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(android, ios);
    notification.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  /// Simply print the payload
  Future onSelectNotification(String payload) {
    debugPrint("Notification payload: " + payload);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: LocalData.appName,
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
      },
    );
  }
}

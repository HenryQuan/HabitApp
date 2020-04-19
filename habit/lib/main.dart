import 'Package:habit/src/ui/pages/HomePage.dart';
import 'package:habit/src/core/LocalData.dart';
import 'package:habit/src/ui/pages/HabitListPage.dart';
import 'package:habit/src/ui/pages/IntroPage.dart';
import 'package:habit/src/ui/pages/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final local = LocalData.shared;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await local.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    final notification = FlutterLocalNotificationsPlugin();
    // TODO: remember to update the app logo for android
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
        accentColor: Colors.blue,
        // scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system,
      initialRoute: local.getInitialRoute(),
      routes: {
        '/home': (context) => HomePage(),
        '/intro': (context) => IntroPage(),
        '/settings': (context) => SettingsPage(),
        '/list': (context) => HabitListPage(),
      },
    );
  }
}

import 'package:Habit/src/core/Utils.dart';
import 'package:Habit/src/ui/widgets/TimerRing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// HomePage class
class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Utils.isDarkTheme(context);
    // Dark -> Light, Light -> Dark
    final adaptiveBrightness = isDarkMode ? Brightness.light : Brightness.dark;
    // Dark -> Grey[900], Light -> Grey[100]
    final adaptiveBarColour = isDarkMode ? Colors.grey[900] : Colors.grey[100];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: Scaffold(
        body: Center(
          child: TimerRing(),
        ),
      ), 
      value: SystemUiOverlayStyle(
        // IOS, status bar brightness
        statusBarBrightness: adaptiveBrightness,
        // Android only, set status bar colour
        statusBarColor: adaptiveBarColour,
        statusBarIconBrightness: adaptiveBrightness,
        // Android only, navigation bar
        systemNavigationBarColor: adaptiveBarColour,
        systemNavigationBarIconBrightness: adaptiveBrightness,
      ),
    );
  }
}

import 'package:HabitApp/src/core/Utils.dart';
import 'package:HabitApp/src/ui/widgets/TimerRing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// HomePage class
class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: Scaffold(
        body: Center(
          child: TimerRing(),
        ),
      ), 
      value: SystemUiOverlayStyle(
        // Set status bar brightness
        statusBarColor:  Utils.isDarkTheme(context) ? Colors.white : Colors.black
      ),
    );
  }
}

import 'package:HabitApp/src/ui/widgets/TimerRing.dart';
import 'package:flutter/material.dart';

/// HomePage class
class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage')
      ),
      body: Center(
        child: TimerRing()
      ),
    );
  }
}

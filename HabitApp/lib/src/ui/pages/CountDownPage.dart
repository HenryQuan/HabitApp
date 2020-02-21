import 'package:HabitApp/src/ui/widgets/TimerRing.dart';
import 'package:flutter/material.dart';

/// CountDownPage class
class CountDownPage extends StatefulWidget {
  CountDownPage({Key key}) : super(key: key);

  @override
  _CountDownPageState createState() => _CountDownPageState();
}


class _CountDownPageState extends State<CountDownPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TimerRing(),
      ),
    );
  }
}

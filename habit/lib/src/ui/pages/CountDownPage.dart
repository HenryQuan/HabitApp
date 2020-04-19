import 'package:habit/src/ui/widgets/ThemedWidget.dart';
import 'package:habit/src/ui/widgets/TimerRing.dart';
import 'package:flutter/material.dart';

/// CountDownPage class
class CountDownPage extends StatelessWidget {
  CountDownPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ThemedWidget(
        child: Center(
          child: TimerRing(),
        ),
      ),
    );
  }
}
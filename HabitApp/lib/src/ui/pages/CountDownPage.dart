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
      appBar: AppBar(
        title: Text('CountDownPage')
      ),
      body: Container(),
    );
  }
}

import 'package:flutter/material.dart';

/// IntroPage class
class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}


class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IntroPage')
      ),
      body: Container(),
    );
  }
}

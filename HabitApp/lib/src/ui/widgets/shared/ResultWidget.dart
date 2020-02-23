import 'package:flutter/material.dart';

/// ResultWidget class
class ResultWidget extends StatefulWidget {
  ResultWidget({Key key}) : super(key: key);

  @override
  _ResultWidgetState createState() => _ResultWidgetState();
}


class _ResultWidgetState extends State<ResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ResultWidget')
      ),
      body: Container(),
    );
  }
}

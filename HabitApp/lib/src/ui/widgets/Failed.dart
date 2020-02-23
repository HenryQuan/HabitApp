import 'package:flutter/material.dart';

/// Failed class
class Failed extends StatefulWidget {
  Failed({Key key}) : super(key: key);

  @override
  _FailedState createState() => _FailedState();
}


class _FailedState extends State<Failed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Failed')
      ),
      body: Container(),
    );
  }
}

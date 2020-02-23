import 'package:flutter/material.dart';

/// HabitListPage class
class HabitListPage extends StatefulWidget {
  HabitListPage({Key key}) : super(key: key);

  @override
  _HabitListPageState createState() => _HabitListPageState();
}


class _HabitListPageState extends State<HabitListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HabitListPage')
      ),
      body: Container(),
    );
  }
}

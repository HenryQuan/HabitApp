import 'package:HabitApp/src/core/models/Habit.dart';
import 'package:HabitApp/src/ui/widgets/HistoryTile.dart';
import 'package:flutter/material.dart';

/// HabitListPage class
class HabitListPage extends StatefulWidget {
  HabitListPage({Key key}) : super(key: key);

  @override
  _HabitListPageState createState() => _HabitListPageState();
}


class _HabitListPageState extends State<HabitListPage> {
  List<Habit> habits = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History')
      ),
      body: AnimatedList(
        itemBuilder: (BuildContext context, int index, Animation<double> animation) { 
          return HistoryTile();
        },
        initialItemCount: 5,
      ),
    );
  }
}

import 'package:HabitApp/src/core/LocalData.dart';
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
  final habits = LocalData().getHistory().history;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History')
      ),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return HistoryTile(habit: habits[index]);
        }
      )
    );
  }
}

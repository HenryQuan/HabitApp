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
  final history = LocalData().getHistory();

  @override
  Widget build(BuildContext context) {
    final habits = history.getHistory();
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(history.totalDaysHumanString()),
            )
          ),
        ],
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

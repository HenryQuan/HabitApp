import 'package:HabitApp/src/core/LocalData.dart';
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
    final vertical = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(vertical ? 16.0 : 0.0),
            child: Center(
              child: Text(history.totalDaysHumanString())
            ),
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

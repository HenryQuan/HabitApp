import 'package:habit/src/core/LocalData.dart';
import 'package:habit/src/ui/widgets/HistoryTile.dart';
import 'package:flutter/material.dart';

/// HabitListPage class
class HabitListPage extends StatefulWidget {
  HabitListPage({Key key}) : super(key: key);

  @override
  _HabitListPageState createState() => _HabitListPageState();
}


class _HabitListPageState extends State<HabitListPage> {
  final history = LocalData.shared.getHistory();

  @override
  Widget build(BuildContext context) {
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
      body: renderBody(),
    );
  }

  Widget renderBody() {
    final habits = history.getHistory();
    if (habits.length == 0) {
      return Center(
        child: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('No history found'),
        )
      );
    } else {
      return ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return HistoryTile(habit: habits[index]);
        }
      );
    }
  }
}

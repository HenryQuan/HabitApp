import 'package:HabitApp/src/core/models/Habit.dart';
import 'package:flutter/material.dart';

/// HistoryTile class
class HistoryTile extends StatefulWidget {
  final Habit habit;
  HistoryTile({Key key, @required this.habit}) : super(key: key);

  @override
  _HistoryTileState createState() => _HistoryTileState();
}


class _HistoryTileState extends State<HistoryTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.habit.name),
      subtitle: Text(widget.habit.getCompletedDateHumanString()),
      leading: Icon(Icons.check, size: 36),
      trailing: Text(widget.habit.getLengthHumanString()),
      onTap: () {},
    );
  }
}

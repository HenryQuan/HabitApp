import 'package:habit/src/core/models/Habit.dart';
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
    final completed = widget.habit.completed;
    return ListTile(
      title: Text(widget.habit.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(widget.habit.getCompletedDateHumanString(), maxLines: 1),
      leading: Icon(
        completed ? Icons.check : Icons.close, 
        size: 36,
        color: completed ? Colors.green[500] : Colors.red[500],
      ),
      trailing: Text(widget.habit.getLengthHumanString()),
      onTap: () {},
    );
  }
}

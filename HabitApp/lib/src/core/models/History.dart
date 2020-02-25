import 'package:HabitApp/src/core/models/Habit.dart';

class History {
  List<Habit> _history = [];
  getHistory() => _history;
  
  History(List<dynamic> saved) {
    saved.forEach((element) {
      _history.add(Habit.fromJson(element));
    });
  }
}
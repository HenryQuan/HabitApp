import 'package:HabitApp/src/core/models/Habit.dart';

class History {
  List<Habit> history = [];
  
  History(List<dynamic> saved) {
    saved.forEach((element) {
      history.add(Habit.fromJson(element));
    });
  }
}
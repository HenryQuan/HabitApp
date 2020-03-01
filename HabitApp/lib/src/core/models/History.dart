import 'dart:convert';

import 'package:HabitApp/src/core/models/Habit.dart';

class History {
  List<Habit> history = [];
  getHistory() => history;
  addToHistory(Habit ended) => history.add(ended);
  
  History();

  History.fromJson(Map<String, dynamic> json) {
    print(json);
    this.history = json['history'];
  }

  Map<String, dynamic> toJson() =>
  {
    'history': jsonEncode(history)
  };

  @override
  String toString() {
    String history = "";
    this.history.forEach((element) => history += element.toString() + "\n");
    return history;
  }
}
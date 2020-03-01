import 'dart:convert';

import 'package:HabitApp/src/core/models/Habit.dart';

class History {
  List<Habit> history = [];
  List<Habit> getHistory() => history;
  void addToHistory(Habit ended) => history.add(ended);
  /// Get total days spent with Henry's Habit App
  String totalDaysHumanString() => '${history.fold(0, (pre, curr) => pre + curr.length)} days';
  
  History();

  History.fromJson(Map<String, dynamic> json) {
    final list = json['history'] as List;
    print(list);
    // Read everything back
    list.forEach((element) {
      this.history.add(Habit.fromJson(element));
    });
  }

  Map<String, dynamic> toJson() =>
  {
    // Convert history into a habit list
    'history': history.map((element) => element.toJson()).toList(),
  };

  @override
  String toString() {
    String history = "";
    this.history.forEach((element) => history += element.toString() + "\n");
    return history;
  }
}
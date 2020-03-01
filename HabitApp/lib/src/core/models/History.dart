import 'package:HabitApp/src/core/models/Habit.dart';

class History {
  List<Habit> history = [];
  List<Habit> getHistory() => history;
  /// Insert new habit to first (so latest first)
  void addToHistory(Habit ended) => history.insert(0, ended);
  /// Get total days spent with Henry's Habit App
  String totalDaysHumanString() => '${history.fold(0, (pre, curr) => pre + curr.progress)}d';
  
  History();

  History.fromJson(Map<String, dynamic> json) {
    final list = json['history'] as List;
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
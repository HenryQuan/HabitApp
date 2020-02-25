class Habit {
  /// Habit name / description
  String name;
  /// How long is this habit in days
  int length;
  /// How many days in
  int progress;
  /// Whether this is completed
  bool completed;
  /// The time of completion
  DateTime date;

  /// Get current percentage of completion
  double getPercentage() {
    return progress.toDouble() / length.toDouble();
  }

  /// for example, Day 1
  String getProgressText() {
    return 'Day $progress';
  }

  Habit(this.name, this.length, this.progress, this.completed, this.date);

  Habit.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        length = json['length'],
        progress = json['progress'],
        completed = json['completed'],
        date = json['date'];

  Map<String, dynamic> toJson() =>
  {
    'name': name,
    'length': length,
    'process': progress,
    'completed': completed,
    'date': date,
  };
}
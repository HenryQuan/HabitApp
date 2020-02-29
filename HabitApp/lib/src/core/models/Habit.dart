class Habit {
  /// Habit name / description
  String name;
  /// How long is this habit in days
  int length;
  /// How many days in, start from 1
  int progress = 0;
  /// Whether this is completed
  bool completed = false;
  /// The time of completion
  DateTime date = DateTime.now();

  /// Check if this habit is still valid
  /// - Check if the difference between date and now is more than 2 days or equivalent
  bool stillOK() {
    final now = DateTime.now();
    // Maximum 2 days and you can get time left by substrcting the last saved date from 48
    final timeLeft = 48 - date.hour;
    // Get diff in hours because days won't work properly
    final diffHours = now.difference(date).inHours;
    // It is still ok if you have more hours
    return diffHours < timeLeft;
  }

  /// Get current percentage of completion
  double getPercentage() {
    return progress.toDouble() / length.toDouble();
  }

  /// Get the percentage as a readable string
  String getPercentageString() {
    // *100 to become 20%
    return (this.getPercentage() * 100).toStringAsFixed(0);
  }

  /// for example, Day 1
  String getProgressText() {
    // Add one to show the correct date
    return 'Day ${progress + 1}';
  }

  /// Only call this after the timer has ended
  void updateHabit() {
    // add one to progress
    progress += 1;

    // we start with 1 so even if progress equals length, it is still the last day
    if (progress >= length) {
      this.completed = true;
    }

    // Update DateTime
    this.date = DateTime.now();
  }

  Habit(this.name, this.length);

  Habit.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        length = json['length'],
        // somehow, 0 is treated as null
        progress = json['process'],
        completed = json['completed'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() =>
  {
    'name': name,
    'length': length,
    'process': progress,
    'completed': completed,
    'date': date.toIso8601String(),
  };

  @override
  String toString() {
    return 'name: $name, length: $length, process: $progress, completed: $completed, date: $date';
  }
}
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

  /// Check if this habit has been done today
  /// - Check if now is the same as saed date
  bool goodToday() {
    final now = DateTime.now();
    // For the first time, date is set to today by default, 
    // so you need to check if process is actually greater than 0. 
    // Otherwise, it will say see you tomorrow even if you haven't done anything
    return progress > 0 && (date.day == now.day 
      && date.month == now.month 
      && date.year == now.year);
  }

  /// Check if it is the next day
  bool isNewDay() {
    // If you did it at 8am, you still have 16 hours to go to pass that day
    final timeLeftToday = 24 - date.hour;
    final now = DateTime.now();
    // Check if the difference is more that time left for today
    return now.difference(date).inHours > timeLeftToday;
  }

  // Whether `ResultWidget` should be rendered
  bool shouldRenderResult() {
    print('Completed - $completed\nGoodToday - ${goodToday()}\nNot OK - ${!stillOK()}');
    return this.completed || this.goodToday() || !this.stillOK();
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

  /// Convert date to something like `Completed on 2020-1-30`
  String getCompletedDateHumanString() {
    final monthPad = date.month.toString().padLeft(2, '0');
    final dayPad = date.day.toString().padLeft(2, '0');
    final timeString = '${date.year}-$monthPad-$dayPad';
    // For failed habits, a different description will be used
    if (completed) {
      return 'Completed on $timeString';
    } else {
      return 'Stopped on $timeString';
    }
  }

  /// A readable string for how long the habit was, `20 days`
  String getLengthHumanString() {
    return '$progress days';
  }

  /// Only call this after the timer has ended
  void updateHabit() {
    // add one to progress if it is a new day, 
    // It should be impossible to add more than one everyday,
    // unless it is day 0
    if (progress == 0) progress = 1;
    if (isNewDay()) progress += 1;

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
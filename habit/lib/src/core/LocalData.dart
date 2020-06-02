import 'dart:convert';

import 'package:habit/src/core/models/Habit.dart';
import 'package:habit/src/core/models/History.dart';
import 'package:habit/src/ui/widgets/ResultWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {

  // Constants
  static const String appVersion = '0.0.6';
  static const String appName = "Henry's Habit App";
  static const String aboutApp = "This app aims to assist you to start new habits. The goal is to do it for one minute everyday. It seems short but it is better than not doing nothing at all. I hope this app could help you accomplish something.\n\nby Henry";
  static const String howToUse = '- Enter your new habit\n- Choose a goal date (at least 5 days)\n- Press "START NOW" and do it for one minute until you see a complete screen\n- Set a reminder so that you don\'t forget about your new habit\n- Repeat until you complete your goal';
  static const int widthDivider = 22;

  SharedPreferences _prefs;
  bool _firstLaunch;

  // Current habit 
  Habit _currHabit;
  Habit getCurrentHabit() => _currHabit;
  /// Update current habit and save it to storage
  void updateCurrHabit({Habit newHabit}) {
    if (newHabit == null){
      // Update current habit
      this._currHabit.updateHabit();
    } else if (this._currHabit == null) {
      // Set it as a new habit
      this._currHabit = newHabit;
    }

    // Write it into loca storage
    _prefs.setString('current', jsonEncode(this._currHabit));
  }

  /// Get appropriate ResultMode depending on whether habit has ended or not
  ResultMode getCorrectMode() {
    return _currHabit.completed ? ResultMode.ended : ResultMode.completed;
  }

  // Habit history
  History _habitHistory = History();
  History getHistory() => _habitHistory;

  // Notification time
  TimeOfDay _notificationTime;
  TimeOfDay getNotificationTime() => _notificationTime;
  void updateNotificationTime(TimeOfDay newTime) {
    // Write it into loca storage
    _notificationTime = newTime;
    String saved = '${newTime.hour},${newTime.minute}';
    _prefs.setString('notification', saved);
  }

  // Singleton pattern 
  LocalData._init();
  static final LocalData shared = new LocalData._init();

  /// Load data and do other things here before app starts
  Future init() async {
    _prefs = await SharedPreferences.getInstance();
    _firstLaunch = _prefs.getBool('firstLaunch') ?? true;

    // Get history
    final savedHistory = _prefs.get('history');
    print('History: $savedHistory');
    if (savedHistory != null) {
      Map historyJson = jsonDecode(savedHistory);
      _habitHistory = History.fromJson(historyJson);
    }

    // Get curent habit
    final habitNow = _prefs.get('current');
    print('Habit: $habitNow');
    if (habitNow != null) {
      Map habitJson = jsonDecode(habitNow);
      // If the saved data is null
      if (habitJson != null) {
        _currHabit = Habit.fromJson(habitJson);
        this.addHabitToHistoryIfNeeded();
      }
    }

    // Get notification time for display
    final time = _prefs.getString('notification');
    print('Notification: $time');
    if (time != null) {
      // Make sure it is valid
      final timeList = time.split(',');
      final h = int.tryParse(timeList[0]);
      final min = int.tryParse(timeList[1]);
      if (h != null && min != null) {
          _notificationTime = TimeOfDay(
          hour: h, 
          minute: min
        );
      }
    }
  }

  /// Check if it is a new day and the status of the habit is completed
  /// - force, for failed habits only
  void addHabitToHistoryIfNeeded({bool force = false}) {
    // Force mode for failed habits
    if (force || (this._currHabit.isNewDay() && this._currHabit.completed)) {
      _habitHistory.addToHistory(this._currHabit);
      // Save this
      _prefs.setString('history', jsonEncode(this._habitHistory));

      // Reset current habit
      this._currHabit = null;
      _prefs.setString('current', jsonEncode(this._currHabit));
    }
  }

  /// Update first launch
  void updateFirstLaunch(bool value) => _prefs.setBool('firstLaunch', value);

  /// If first launch, intro. Otherwise, home page
  String getInitialRoute() => _firstLaunch ? '/intro' : '/home';

}
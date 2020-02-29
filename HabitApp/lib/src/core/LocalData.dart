import 'dart:convert';

import 'package:HabitApp/src/core/models/Habit.dart';
import 'package:HabitApp/src/core/models/History.dart';
import 'package:HabitApp/src/ui/widgets/ResultWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {

  // Constants
  static const String appVersion = '1.0.0';
  static const String appName = "Henry's Habit App";
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
  History _habitHistory;

  // Singleton pattern 
  LocalData._init();
  static final LocalData _instance = new LocalData._init();

  // Use dart's factory constructor to implement this pattern
  factory LocalData() {
    return _instance;
  }

  /// Load data and do other things here before app starts
  Future init() async {
    _prefs = await SharedPreferences.getInstance();
    _firstLaunch = _prefs.getBool('firstLaunch') ?? true;

    final savedHistory = _prefs.get('history');
    if (savedHistory != null) {
      _habitHistory = new History(savedHistory);
    }

    final habitNow = _prefs.get('current');
    print(habitNow);
    if (habitNow != null) {
      Map habitJson = jsonDecode(habitNow);
      // If the saved data is null
      if (habitJson != null) {
        _currHabit = new Habit.fromJson(habitJson);
        print(_currHabit);
      }
    }
  }

  /// Update first launch
  void updateFirstLaunch(bool value) => _prefs.setBool('firstLaunch', value);

  /// If first launch, intro. Otherwise, home page
  String getInitialRoute() => _firstLaunch ? '/intro' : '/home';

}
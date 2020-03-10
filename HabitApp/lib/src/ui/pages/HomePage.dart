import 'Package:HabitApp/src/core/Utils.dart';
import 'package:HabitApp/src/core/LocalData.dart';
import 'package:HabitApp/src/core/models/Habit.dart';
import 'package:HabitApp/src/ui/pages/CountDownPage.dart';
import 'package:HabitApp/src/ui/widgets/ResultWidget.dart';
import 'package:HabitApp/src/ui/widgets/ThemedWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// HomePage class
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int howManyDays = 0;
  bool showStartButton = false;
  final inputController = TextEditingController();
  final local = LocalData();
  Habit habit;

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Utils.isDarkTheme(context);
    // Somehow, AppBar overrides it...
    Utils.setStatusBarColour(context);

    final deviceWidth = Utils.getBestWidth(context);
    this.habit = local.getCurrentHabit();
    if (habit != null) {
      showStartButton = true;
      howManyDays = habit.length;
    }

    // failed or completed
    bool renderResult = this.habit?.shouldRenderResult() ?? false;
    print('renderResult is $renderResult');

    return ThemedWidget(
      child: renderResult && habit != null ? 
      Scaffold(
        body: Center(
          // Render failed if failed
          child: this.renderResult(MediaQuery.of(context).size),
        ),
      ) : 
      Scaffold(
        appBar: AppBar(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
          title: Text(habit?.getProgressText() ?? 'Day 1' ),
          leading: IconButton(
            tooltip: 'History',
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/list');
            },
          ),
          actions: <Widget>[
            IconButton(
              tooltip: 'How does it work?',
              icon: Icon(Icons.help_outline),
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('How does it work?'),
                      content: Text(LocalData.howToUse),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            IconButton(
              tooltip: 'Settings',
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              this.renderNewHabit(isDarkMode, deviceWidth),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: AnimatedOpacity(
                    opacity: this.showStartButton ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: FlatButton.icon(
                      // Prevent user from pressing this button randomly
                      onPressed: this.showStartButton ? () {
                        // Show a fullscreen dialog on both systems
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => CountDownPage(), fullscreenDialog: true)
                        );

                        // Update current habit
                        local.updateCurrHabit(newHabit: Habit(inputController.text, this.howManyDays));
                      } : null,
                      icon: Icon(Icons.play_arrow), 
                      label: Text('START NOW')
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), 
    );
  }

  /// Render `ResultWidget` if
  /// - you did it today (completed)
  /// - the habit ends
  /// - you didn't do it yersterday
  Widget renderResult(Size size) {
    ResultMode mode;
    bool animated = false;
    if (!this.habit.stillOK()) {
      mode = ResultMode.failed;
      animated = true;
    } else if (this.habit.completed) mode = ResultMode.ended;
    else mode = ResultMode.completed;

    return ResultWidget(
      mode: mode, 
      deviceSize: size,
      animated: animated
    );
  }

  Widget renderNewHabit(bool isDarkMode, double deviceWidth) {
    final fontSize = deviceWidth / 18;
    final fontSizeHabit = deviceWidth / 12;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        habit == null ? TextField(
          enabled: habit == null,
          maxLines: 1,
          controller: inputController,
          onChanged: (value) {
            // Update current text
            setState(() {
              showStartButton = this.shouldShowStartButton();
            });
          },
          autocorrect: false,
          cursorColor: isDarkMode ? Colors.white : Colors.black,
          enableInteractiveSelection: false,
          style: TextStyle(fontSize: fontSizeHabit, fontStyle: FontStyle.italic),
          decoration: InputDecoration(
            hintText: 'a new habit',
            hintStyle: TextStyle(fontSize: fontSizeHabit, fontStyle: FontStyle.italic),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          textAlign: TextAlign.center,
        ) : Text(
          habit.name,
          style: TextStyle(fontSize: fontSizeHabit, fontStyle: FontStyle.italic),
        ),
        Tooltip(
          message: 'Select a date here',
          child: FlatButton(
            child: Text(
              howManyDays == 0 ? 'everyday until when?' : 'everyday for $howManyDays days',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w300,
                decoration: howManyDays == 0 ? TextDecoration.underline : null,
              ),
            ),
            onPressed: habit == null ? () {
              // Dismiss keyboard
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                // Unfocus and dismiss keyboard
                currentFocus.unfocus();
              }

              final now = DateTime.now();
              // At least, 5 days...
              final firstDate = DateTime(now.year, now.month, now.day).add(Duration(days: 5));
              // At most, 100 days!
              final lastDate = firstDate.add(Duration(days: 96));
              showDatePicker(
                context: context, 
                initialDate: firstDate,
                firstDate: firstDate,
                lastDate: lastDate,
              ).then((value) {
                setState(() {
                  howManyDays = this.convertDateToDays(value);
                  showStartButton = this.shouldShowStartButton();
                });
              });
            } : null,
          ),
        ),
      ],
    );
  }

  /// Whether the start button should be shown
  /// - Only show if all entries have been entered
  bool shouldShowStartButton() {
    return this.howManyDays > 0 && this.inputController.text.length > 0;
  }

  /// Convert date time into how many days
  int convertDateToDays(DateTime date) {
    // Also include today so different + 1
    return date.difference(DateTime.now()).inDays + 1;
  }
}

import 'Package:habit/src/core/Utils.dart';
import 'package:habit/src/core/LocalData.dart';
import 'package:habit/src/core/models/Habit.dart';
import 'package:habit/src/ui/pages/CountDownPage.dart';
import 'package:habit/src/ui/widgets/ResultWidget.dart';
import 'package:habit/src/ui/widgets/ThemedWidget.dart';
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
  final local = LocalData.shared;

  Habit habit;
  bool showResult;
  bool completedOrSkip = false;

  @override
  void initState() {
    super.initState();

    this.habit = local.getCurrentHabit();
    if (habit != null) {
      this.showStartButton = true;
      this.howManyDays = habit.length;
    }

    this.showResult = this.habit?.shouldRenderResult() ?? false;
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final util = Utils.of(context);
    if (!util.isTablet()) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    final isDarkMode = util.isDarkTheme();
    // Somehow, AppBar overrides it...
    util.setStatusBarColour();

    final deviceWidth = util.getBestWidth();
    bool showResult = this.habit?.shouldRenderResult() ?? false;
    print('renderResult is $renderResult');

    // failed or completed
    if (showResult && habit != null) return renderResult(context, animated: completedOrSkip);
    return Scaffold(
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
          buildInfoButton(context),
          buildSettingsButton(context),
        ],
      ),
      body: ThemedWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            this.renderNewHabit(isDarkMode, deviceWidth),
            Column(
              children: <Widget>[
                this.buildStartButton(context),
                ...renderSkilOrComplete(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> renderSkilOrComplete() {
    if (habit == null) return [];

    final onPress = () {
      local.updateCurrHabit();
      setState(() {
        // Update the UI and show the result screen with animation
        completedOrSkip = true;
        showResult = true;
      });
    };

    return [
      Divider(),
      HabitIconButton(
        display: showStartButton, 
        child: FlatButton.icon(
          onPressed: onPress, 
          icon: Icon(Icons.check), 
          label: Text('COMPLETED')
        ),
      ),
      HabitIconButton(
        display: showStartButton, 
        child: FlatButton.icon(
          onPressed: onPress,
          icon: Icon(Icons.skip_next), 
          label: Text('SKIP')
        ),
      ),
    ];
  }

  Widget buildStartButton(BuildContext context) {
    return HabitIconButton(
      display: showStartButton,
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
    );
  }

  IconButton buildInfoButton(BuildContext context) {
    return IconButton(
      tooltip: 'Information about how to use this app',
      icon: Icon(Icons.help_outline),
      onPressed: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('How to use?'),
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
    );
  }

  IconButton buildSettingsButton(BuildContext context) {
    return IconButton(
      tooltip: 'Settings',
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.pushNamed(context, '/settings');
      },
    );
  }

  /// Render `ResultWidget` if
  /// - you did it today (completed)
  /// - the habit ends
  /// - you didn't do it yersterday
  Widget renderResult(BuildContext context, {bool animated = false}) {
    ResultMode mode;
    if (!this.habit.stillOK()) {
      mode = ResultMode.failed;
      animated = true;
    } 
    else if (this.habit.completed) mode = ResultMode.ended;
    else mode = ResultMode.completed;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ResultWidget(
          mode: mode, 
          deviceSize: size,
          animated: animated
        ),
      ),
    );
  }

  Widget renderNewHabit(bool isDarkMode, double deviceWidth) {
    final fontSize = deviceWidth / 18;
    final fontSizeHabit = deviceWidth / 12;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        habit == null 
        ? buildTextInput(isDarkMode, fontSizeHabit) 
        : buildHabitText(fontSizeHabit),
        buildDateSelection(fontSize),
      ],
    );
  }

  Text buildHabitText(double fontSizeHabit) {
    return Text(
      habit.name,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSizeHabit, fontStyle: FontStyle.italic),
    );
  }

  TextField buildTextInput(bool isDarkMode, double fontSizeHabit) {
    return TextField(
      enabled: habit == null,
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
    );
  }

  Tooltip buildDateSelection(double fontSize) {
    return Tooltip(
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
            if (value != null) {
              setState(() {
                howManyDays = this.convertDateToDays(value);
                showStartButton = this.shouldShowStartButton();
              });
            }
          });
        } : null,
      ),
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

class HabitIconButton extends StatelessWidget {
  final bool display;
  final Widget child;

  const HabitIconButton({
    Key key,
    @required this.display,
    @required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: this.display ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: FractionallySizedBox(
        widthFactor: 0.618,
        child: child,
      ),
    );
  }
}

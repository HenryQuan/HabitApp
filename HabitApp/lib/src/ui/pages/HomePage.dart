import 'Package:HabitApp/src/core/Utils.dart';
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

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Utils.isDarkTheme(context);
    final deviceWidth = Utils.getBestWidth(context);

    return ThemedWidget(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppBar(
                title: Text('Day 1'),
                leading: IconButton(
                  icon: Icon(Icons.history),
                  onPressed: () {
                    Navigator.pushNamed(context, '/list');
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ],
              ),
              this.renderNewHabit(isDarkMode, deviceWidth),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: AnimatedOpacity(
                      opacity: this.showStartButton ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 300),
                      child: FlatButton.icon(
                        onPressed: () {
                          // Prevent user from pressing this button randomly
                          if (this.showStartButton) {
                            Navigator.pushReplacementNamed(context, '/timer');
                          }
                        },
                        icon: Icon(Icons.play_arrow), 
                        label: Text('START NOW')
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ), 
    );
  }

  Widget renderNewHabit(bool isDarkMode, double deviceWidth) {
    final fontSize = deviceWidth / 14;
    final fontSizeHabit = deviceWidth / 10;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          maxLines: 1,
          controller: inputController,
          onChanged: (value) {
            // Update current text
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
        ),
        FlatButton(
          child: Text(
            howManyDays == 0 ? 'everyday until when?' : 'everyday for $howManyDays days',
            style: TextStyle(
              fontSize: fontSize,
              decoration: howManyDays == 0 ? TextDecoration.underline : null,
            ),
          ),
          onPressed: () {
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
              });
            });
          },
        ),
      ],
    );
  }

  /// Whether the start button should be shown
  /// - Only show if all entries have been entered
  bool shouldShowStartButton() {
    return this.howManyDays > 0;
  }

  /// Convert date time into how many days
  int convertDateToDays(DateTime date) {
    // Also include today so different + 1
    return date.difference(DateTime.now()).inDays + 1;
  }
}

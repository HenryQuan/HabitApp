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
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/timer');
                      },
                      icon: Icon(Icons.play_arrow), 
                      label: Text('START NOW')
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
        Text(
          'I am going to',
          style: TextStyle(fontSize: fontSize),
        ),
        TextField(
          maxLines: 1,
          keyboardType: TextInputType.text,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text(howManyDays == 0 ? 'until when?' : 'for $howManyDays days'),
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
            )
          ],
        ),
      ],
    );
  }

  /// Convert date time into how many days
  int convertDateToDays(DateTime date) {
    // Also include today so different + 1
    return date.difference(DateTime.now()).inDays + 1;
  }
}

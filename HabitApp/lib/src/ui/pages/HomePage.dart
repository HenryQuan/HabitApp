import 'Package:HabitApp/src/core/Utils.dart';
import 'package:HabitApp/src/ui/widgets/ThemedWidget.dart';
import 'package:flutter/material.dart';

/// HomePage class
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Utils.isDarkTheme(context);

    return ThemedWidget(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppBar(
                title: Text("Day 1 of 60"),
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
              this.renderNewHabit(isDarkMode),
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

  Widget renderNewHabit(bool isDarkMode) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'I want to',
          style: TextStyle(fontSize: 32),
        ),
        Padding(
          padding: EdgeInsets.all(0.0),
          child: TextField(
            maxLines: 1,
            cursorColor: isDarkMode ? Colors.white : Colors.black,
            enableInteractiveSelection: false,
            style: TextStyle(fontSize: 32, fontStyle: FontStyle.italic),
            decoration: InputDecoration(
              hintText: 'a new habit',
              hintStyle: TextStyle(fontSize: 32, fontStyle: FontStyle.italic),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'for',
              style: TextStyle(fontSize: 32),
            ),
            DropdownButton(
              items: [],
              value: [], 
              onChanged: (value) {  },
              hint: Text(' how long? ', style: TextStyle(fontSize: 32)),
            )
          ],
        ),
      ],
    );
  }
}

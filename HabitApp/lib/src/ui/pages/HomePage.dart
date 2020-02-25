import 'Package:HabitApp/src/core/Utils.dart';
import 'package:HabitApp/src/ui/pages/CountDownPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// HomePage class
class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Utils.isDarkTheme(context);
    // Dark -> Light, Light -> Dark
    final adaptiveBrightnessIOS = isDarkMode ? Brightness.dark : Brightness.light;
    final adaptiveBrightnessAndroid = !isDarkMode ? Brightness.dark : Brightness.light;
    // Dark -> Grey[900], Light -> Grey[100]
    final adaptiveBarColour = isDarkMode ? Colors.grey[900] : Colors.grey[100];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: Scaffold(
        body: Stack(
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
                padding: const EdgeInsets.all(32.0),
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
        )
      ), 
      value: SystemUiOverlayStyle(
        // IOS, status bar brightness
        statusBarBrightness: adaptiveBrightnessIOS,
        // Android only, set status bar colour
        statusBarColor: adaptiveBarColour,
        statusBarIconBrightness: adaptiveBrightnessAndroid,
        // Android only, navigation bar
        systemNavigationBarColor: adaptiveBarColour,
        systemNavigationBarIconBrightness: adaptiveBrightnessAndroid,
      ),
    );
  }

  Widget renderNewHabit(bool isDarkMode) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'I want to start',
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

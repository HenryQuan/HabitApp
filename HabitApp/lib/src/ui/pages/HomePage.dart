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
    final adaptiveBrightness = isDarkMode ? Brightness.light : Brightness.dark;
    // Dark -> Grey[900], Light -> Grey[100]
    final adaptiveBarColour = isDarkMode ? Colors.grey[900] : Colors.grey[100];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'I want to start',
                style: TextStyle(fontSize: 32),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                    hint: Text('         '),
                  )
                ],
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CountDownPage())
                  );
                },
              ),
            ],
          ),
        )
      ), 
      value: SystemUiOverlayStyle(
        // IOS, status bar brightness
        statusBarBrightness: adaptiveBrightness,
        // Android only, set status bar colour
        statusBarColor: adaptiveBarColour,
        statusBarIconBrightness: adaptiveBrightness,
        // Android only, navigation bar
        systemNavigationBarColor: adaptiveBarColour,
        systemNavigationBarIconBrightness: adaptiveBrightness,
      ),
    );
  }
}

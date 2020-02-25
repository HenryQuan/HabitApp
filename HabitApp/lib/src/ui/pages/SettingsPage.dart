import 'package:HabitApp/src/core/LocalData.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// SettingsPage class
class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TimeOfDay reminderTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings')
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Reminder'),
            subtitle: Text(reminderTime != null ? reminderTime.format(context) : 'Choose a time'),
            onTap: () {
              Future<TimeOfDay> selectedTime = showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              );

              selectedTime.then((value) {
                setState(() {
                  reminderTime = value;
                });
              });
            },
          ),
          Divider(),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Feedback'),
                  subtitle: Text('Send an email to the developer'),
                  onTap: () {
                    launch('mailto:development.henryquan@gmail.com?subject=[HabitApp 1.0.0]');
                  },
                ),
                ListTile(
                  onTap: () {
                    launch('https://github.com/HenryQuan/HabitApp');
                  },
                  title: Text('Source code'),
                  subtitle: Text('Checkout the source code on GitHub'),
                ),
                ListTile(
                  title: Text('Licenses'),
                  subtitle: Text('Check all open source licenses'),
                  onTap: () {
                    showLicensePage(
                      context: context,
                      applicationName: "Henry's Habit App",
                      applicationVersion: LocalData.appVersion,
                      applicationLegalese: 'Start a new habit today'
                    );
                  },
                ),
                ListTile(
                  title: Text('Version'),
                  subtitle: Text(LocalData.appVersion),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

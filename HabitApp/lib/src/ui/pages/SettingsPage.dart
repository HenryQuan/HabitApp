import 'package:HabitApp/src/core/LocalData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

/// SettingsPage class
class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  LocalData local;
  TimeOfDay reminderTime;
  FlutterLocalNotificationsPlugin notifcation;

  @override
  void initState() {
    super.initState();
    this.notifcation = FlutterLocalNotificationsPlugin();
    this.local = LocalData();
    this.reminderTime = local.getNotificationTime();
  }

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
            onTap: () async {
              Future<TimeOfDay> selectedTime = showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              );

              selectedTime.then((value) async {
                // Cancel current notification
                this.notifcation.cancelAll();
                // Save notification time
                this.local.updateNotificationTime(value);
                setState(() {
                  reminderTime = value;
                });

                // Update notification time
                final ios = IOSNotificationDetails(presentBadge: true, presentAlert: true, badgeNumber: 0, presentSound: true);
                final android = AndroidNotificationDetails('habit', 'habit_app', 'daily reminder');
                final platformDetails = NotificationDetails(android, ios);
                // Update new notifications (2 of them)
                await this.notifcation.showDailyAtTime(
                  0, 
                  "Henry's Habit App", 
                  "Don't forget about your habit", 
                  Time(value.hour, value.minute, 0), 
                  platformDetails
                );

                await this.notifcation.showDailyAtTime(
                  1, 
                  "Henry's Habit App", 
                  "Don't forget about your habit", 
                  Time(value.hour, value.minute, 10), 
                  platformDetails
                );
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
                  title: Text(LocalData.appName),
                  subtitle: Text(LocalData.appVersion),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: LocalData.appName,
                      applicationVersion: LocalData.appVersion,
                      applicationLegalese: 'Put about here'
                    );
                  },
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

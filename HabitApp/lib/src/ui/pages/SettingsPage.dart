import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// SettingsPage class
class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings')
      ),
      body: ListView(
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
            subtitle: Text('Checkout the souce code hosting on GitHub'),
          ),
          ListTile(
            title: Text('Licenses'),
            subtitle: Text('Check all open source licenses'),
            onTap: () {
              showLicensePage(context: context);
            },
          ),
          ListTile(
            onTap: () {
              launch('https://github.com/HenryQuan/HabitApp');
            },
            subtitle: Text('1.0.0'),
          ),
        ],
      )
    );
  }
}

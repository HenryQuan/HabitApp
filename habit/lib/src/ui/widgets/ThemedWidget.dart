import 'package:habit/src/core/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ThemedWidget class, it appies correct status bar and navigation bar style to both IOS and Android
class ThemedWidget extends StatelessWidget {
  final Widget child;

  ThemedWidget({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Utils.of(context).isDarkTheme();
    // Dark -> Light, Light -> Dark
    final adaptiveBrightnessIOS = isDarkMode ? Brightness.dark : Brightness.light;
    final adaptiveBrightnessAndroid = !isDarkMode ? Brightness.dark : Brightness.light;
    // Dark -> Grey[900], Light -> Grey[100]
    final adaptiveBarColour = isDarkMode ? Colors.grey[900] : Colors.grey[100];

    return AnnotatedRegion<SystemUiOverlayStyle>(
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
      child: SafeArea(
        child: this.child,
      ),
    );
  }
}

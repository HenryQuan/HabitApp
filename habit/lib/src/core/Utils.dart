import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  static of(BuildContext context) => Utils(context);

  /// Get current system brightness
  Brightness getSystemBrightness() {
    return MediaQuery.of(context).platformBrightness;
  }

  /// Check if it is currently dark theme
  bool isDarkTheme() {
    return getSystemBrightness() == Brightness.dark;
  }

  /// Always return the short side
  double getBestWidth() {
    final size = MediaQuery.of(context).size;
    return size.height < size.width ? size.height : size.width;
  }

  // Get the right colour based on mode
  Color getStatusBarColour(bool isDarkMode) {
    return isDarkMode ? Colors.grey[900] : Colors.grey[100];
  }

  /// Set adaptive status bar colour
  void setStatusBarColour() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: getStatusBarColour(isDarkTheme())
    ));
  }

  /// From https://stackoverflow.com/a/53912090
  bool isTablet() {
    var size = MediaQuery.of(context).size;
    var diagonal = sqrt(
      (size.width * size.width) + 
      (size.height * size.height)
    );

    var isTablet = diagonal > 1100.0;
    return isTablet;
  }
}
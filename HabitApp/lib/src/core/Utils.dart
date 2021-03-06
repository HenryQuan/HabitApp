import 'dart:ui';

import 'package:flutter/widgets.dart';

class Utils {
  /// Get current system brightness
  static Brightness getSystemBrightness(BuildContext context) {
    return MediaQuery.of(context).platformBrightness;
  }

  /// Check if it is currently dark theme
  static bool isDarkTheme(BuildContext context) {
    return Utils.getSystemBrightness(context) == Brightness.dark;
  }

  /// Always return the short side
  static double getBestWidth(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.height < size.width ? size.height : size.width;
  }
}
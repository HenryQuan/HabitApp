import 'dart:ui';

import 'package:flutter/widgets.dart';

class Utils {
  /// Check if it is currently dark theme
  static bool isDarkTheme(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }
}
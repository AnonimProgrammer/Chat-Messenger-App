import 'package:chat_messenger_app/themes/darkmode.dart';
import 'package:chat_messenger_app/themes/lightmode.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // light mode
  ThemeData _themeData = lightmode;
  ThemeData get themeData => _themeData;

  // is current theme dark mode(bool)
  bool get isDarkMode => _themeData == darkmode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // toggle theme
  void toggleTheme() {
    if (_themeData == lightmode) {
      themeData = darkmode;
    } else {
      themeData = lightmode;
    }
  }
}

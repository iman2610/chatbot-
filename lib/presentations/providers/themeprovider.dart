import 'package:flutter/material.dart';

import '../screens/theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData Function(BuildContext context) get themeData =>
      _isDarkMode ? darkThemeData : lightThemeData;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
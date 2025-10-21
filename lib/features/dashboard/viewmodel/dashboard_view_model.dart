import 'package:flutter/material.dart';

import '../../../app/themes/theme_dark.dart';
import '../../../app/themes/theme_light.dart';

class DashboardViewModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  int _selectedDrawerIndex = -1;

  int get selectedDrawerIndex => _selectedDrawerIndex;

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }

  void setSelectedDrawerIndex(int index) {
    _selectedDrawerIndex = index;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }
}

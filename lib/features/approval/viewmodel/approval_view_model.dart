import 'package:flutter/material.dart';

import '../../../app/themes/theme_dark.dart';
import '../../../app/themes/theme_light.dart';

class ApprovalViewModel extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  int _segmentedButton = 0;
  int get segmentedButton => _segmentedButton;

  int _drawerIndex = -1;
  int get drawerIndex => _drawerIndex;

  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  void incrementCounter() async {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }

  void selectedSegmentedButton(int index) async{
    _segmentedButton = index;
    notifyListeners();
  }

  void setSelectedDrawerIndex(int index) async{
    _drawerIndex = index;
    notifyListeners();
  }

  void toggleTheme() async {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }
}
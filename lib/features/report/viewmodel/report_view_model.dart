import 'package:flutter/cupertino.dart';

class ReportViewModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  int _drawerIndex = 0;

  int get drawerIndex => _drawerIndex;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }

  void setSelectedDrawerIndex(int index) async {
    _drawerIndex = index;
    notifyListeners();
  }
}

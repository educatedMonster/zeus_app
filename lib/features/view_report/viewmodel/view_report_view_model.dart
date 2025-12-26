import 'package:flutter/cupertino.dart';

class ViewReportViewModel extends ChangeNotifier {
  // -------------------------
  // Scroll controllers
  // -------------------------
  late final ScrollController parentController;
  late final ScrollController childController;

  ViewReportViewModel() {
    parentController = ScrollController();
    childController = ScrollController();
  }

  @override
  void dispose() {
    parentController.dispose();
    childController.dispose();
    super.dispose();
  }

  int _counter = 0;
  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }
}

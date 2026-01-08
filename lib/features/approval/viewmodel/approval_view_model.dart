import 'package:flutter/material.dart';

class ApprovalViewModel extends ChangeNotifier {
  // -------------------------
  // Scroll controllers
  // -------------------------
  late final ScrollController pendingParentController;
  late final ScrollController approvedParentController;
  late final ScrollController returnedParentController;
  late final ScrollController rejectedParentController;
  late final ScrollController childController;

  ApprovalViewModel() {
    pendingParentController = ScrollController();
    approvedParentController = ScrollController();
    returnedParentController = ScrollController();
    rejectedParentController = ScrollController();
    childController = ScrollController();
  }

  @override
  void dispose() {
    pendingParentController.dispose();
    approvedParentController.dispose();
    returnedParentController.dispose();
    rejectedParentController.dispose();
    childController.dispose();
    super.dispose();
  }

  int _counter = 0;

  int get counter => _counter;

  String _calendarView = 'High';

  String get calendarView => _calendarView;

  void incrementCounter() async {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }

  void selectedCalendarView(String selected) async {
    _calendarView = selected;
    notifyListeners();
  }
}

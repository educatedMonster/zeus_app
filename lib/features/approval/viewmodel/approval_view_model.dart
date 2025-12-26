import 'package:flutter/material.dart';

import '../../../app/themes/theme_dark.dart';
import '../../../app/themes/theme_light.dart';

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

  int _segmentedButton = 0;
  int get segmentedButton => _segmentedButton;

  int _drawerIndex = -1;
  int get drawerIndex => _drawerIndex;

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
}
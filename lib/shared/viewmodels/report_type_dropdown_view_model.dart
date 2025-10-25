import 'package:flutter/widgets.dart';

class ReportTypeDropdownViewModel extends ChangeNotifier {
  String _selectedReport = '';

  String get selectedReport => _selectedReport;

  void setSelectedReport(String value) async {
    _selectedReport = value;
    notifyListeners();
  }
}

import 'package:flutter/widgets.dart';

class FileFormatDropdownViewModel extends ChangeNotifier {
  String _selectedFormat = '';

  String get selectedFormat => _selectedFormat;

  void setSelectedFormat(String value) async {
    _selectedFormat = value;
    notifyListeners();
  }
}

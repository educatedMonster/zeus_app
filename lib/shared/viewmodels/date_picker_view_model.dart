import 'package:flutter/cupertino.dart';

import '../../core/utils/date_formatter.dart';

class DatePickerViewModel extends ChangeNotifier {
  DateItem _date = DateItem(
    formatedDate: formattedDate(DateTime.now()),
    date: DateTime.now(),
  );

  DateItem get date => _date;

  void setDate(DateItem date) {
    _date = date;
    notifyListeners();
  }

  void resetDate() {
    _date = DateItem(
      formatedDate: formattedDate(DateTime.now()),
      date: DateTime.now(),
    );
    notifyListeners();
  }
}

class DateItem {
  final String formatedDate;
  final DateTime date;

  DateItem({required this.formatedDate, required this.date});

  // copyWith method
  DateItem copyWith({String? formatedDate, DateTime? date}) {
    return DateItem(
      formatedDate: formatedDate ?? this.formatedDate,
      date: date ?? this.date,
    );
  }

  @override
  String toString() => 'DateItem(formatedDate: $formatedDate, date: $date)';
}

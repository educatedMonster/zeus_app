import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/utils/date_formatter.dart';
import '../viewmodels/date_picker_view_model.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    DateItem date = DateItem(
      formatedDate: formattedDate(DateTime.now()),
      date: DateTime.now(),
    );

    DatePickerViewModel datePickerViewModel = context.watch();

    date = datePickerViewModel.date;

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date.date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.teal, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.teal, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        print('Selected date: $picked');
        print('Formatted date: ${formattedDate(picked)}');
        context.read<DatePickerViewModel>().setDate(
          date.copyWith(formatedDate: formattedDate(picked), date: picked),
        );
      }
    }

    return InkWell(
      onTap: () {
        selectDate(context);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16.0, right: 8.0).r,
        child: Row(
          children: [
            Row(
              spacing: 8.0.r,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.black54,
                  size: 16.0.r,
                ),
                Text(
                  date.formatedDate,
                  style: TextStyle(color: Colors.black87, fontSize: 14.0.sp),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, size: 16.0.r),
                  color: Colors.black87,
                  onPressed: () {
                    //  Subtract 1 day
                    final oneDayLater = date.date.subtract(
                      const Duration(days: 1),
                    );

                    context.read<DatePickerViewModel>().setDate(
                      date.copyWith(
                        formatedDate: formattedDate(oneDayLater),
                        date: oneDayLater,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 16.0.r),
                  color: Colors.black87,
                  onPressed: () {
                    //  Add 1 day
                    final oneDayAfter = date.date.subtract(
                      const Duration(days: 1),
                    );

                    context.read<DatePickerViewModel>().setDate(
                      date.copyWith(
                        formatedDate: formattedDate(oneDayAfter),
                        date: oneDayAfter,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

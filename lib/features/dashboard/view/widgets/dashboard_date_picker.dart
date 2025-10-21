import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DashboardDatePicker extends StatelessWidget {
  const DashboardDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateFormat(
      'MMM d, yyyy',
    ).format(DateTime(2025, 8, 17)); // Example date

    return Container(
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
                today,
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
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios, size: 16.0.r),
                color: Colors.black87,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseDialogHeader extends StatelessWidget {
  final ColorScheme colorScheme;
  final String title;
  final String date;
  final VoidCallback onHistoryTap;

  const PurchaseDialogHeader({
    super.key,
    required this.colorScheme,
    required this.title,
    required this.date,
    required this.onHistoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .center,
      mainAxisAlignment: .spaceBetween,
      mainAxisSize: .max,
      children: [
        Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0.sp),
            ),

            Text(
              date,
              style: TextStyle(
                color: colorScheme.onTertiary,
                fontSize: 11.0.sp,
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.edit_outlined, color: colorScheme.onSecondary),
          onPressed: onHistoryTap,
        ),
      ],
    );
  }
}

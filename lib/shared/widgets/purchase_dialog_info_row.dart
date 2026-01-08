import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseDialogInfoRow extends StatelessWidget {
  final ColorScheme colorScheme;
  final IconData icon;
  final String label;
  final String value;

  const PurchaseDialogInfoRow({
    super.key,
    required this.colorScheme,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
      child: Row(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        spacing: 8.0.r,
        children: [
          Icon(icon, color: colorScheme.onTertiary, size: 22.0.r),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              mainAxisSize: .max,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: colorScheme.onTertiary,
                    fontSize: 12.0.sp,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

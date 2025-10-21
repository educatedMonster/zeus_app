import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/utils/extensions.dart';

class ViewReportTimekeeping2Card extends StatelessWidget {
  final Color statusColor;
  final String label;

  const ViewReportTimekeeping2Card({
    super.key,
    required this.statusColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 16.0.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        spacing: 8.0.r,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            '15',
            style: TextStyle(
              color: statusColor,
              fontSize: 16.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

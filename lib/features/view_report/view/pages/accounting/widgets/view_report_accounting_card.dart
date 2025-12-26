import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/utils/extensions.dart';

class ViewReportAccountingCard extends StatelessWidget {
  const ViewReportAccountingCard({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 16.0.r),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.surfaceContainer.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        spacing: 8.0.r,
        children: [
          Text(
            'Current Ratio',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            '1.8',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 16.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

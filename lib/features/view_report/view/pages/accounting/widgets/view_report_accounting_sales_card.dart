import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/utils/extensions.dart';

class ViewReportAccountingSalesCard extends StatelessWidget {
  final bool isNegativeStatus;

  const ViewReportAccountingSalesCard({
    super.key,
    this.isNegativeStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0).r,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.0).r,
        boxShadow: [
          BoxShadow(
            color: colorScheme.surfaceContainer.withValues(alpha: 0.1),
            blurRadius: 10.0.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .spaceBetween,
        spacing: 4.0.r,
        children: [
          Row(
            crossAxisAlignment: .center,
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                'Net Sales',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                'last week',
                style: TextStyle(
                  color: colorScheme.onSecondary,
                  fontSize: 10.0.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: .center,
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                '69,600.00',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 8.0,
                ).r,
                decoration: BoxDecoration(
                  color: isNegativeStatus ? Colors.red : Colors.green, // Green background for the percentage
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Row(
                  spacing: 4.0.r,
                  children: [
                    Icon(
                      isNegativeStatus ? Icons.trending_down : Icons.trending_up,
                      color: colorScheme.surface,
                      size: 16.0.r,
                    ),
                    Text(
                      isNegativeStatus ? '-8.2%' : '+8.2%',
                      style: TextStyle(
                        color: colorScheme.surface,
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/utils/extensions.dart';

class ViewReportPosSalesCard extends StatelessWidget {
  const ViewReportPosSalesCard({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 8.0).r,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.0.r,
            children: [
              Text(
                'Net Sales',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '69,600.00',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'last week',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0).r,
                decoration: BoxDecoration(
                  color: Colors.green, // Green background for the percentage
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  spacing: 4.0.r,
                  children: [
                    Icon(Icons.trending_up, color: colorScheme.surface, size: 16.0.r),
                    Text(
                      '+8.2%',
                      style: TextStyle(
                        color: colorScheme.surface,
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.bold,
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/extensions.dart';

class DashboardRevenueCard extends StatelessWidget {
  const DashboardRevenueCard({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();

    return Container(
      width: context.contextWidth(),
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
      child: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .center,
        children: [
          /// Left Section
          Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .spaceBetween,
            spacing: 4.0.r,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Total Revenue',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '524,000.00',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Revenue PAR',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '15,000.00',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// Right Section
          Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .spaceBetween,
            spacing: 4.0.r,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Occupancy Rate',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '24%',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: .start,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: colorScheme.onSurface.withValues(alpha: 0.25),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      // padding: EdgeInsets.symmetric(
                      //   horizontal: 16.0.r,
                      //   vertical: 8.0.r,
                      // ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'View Full Report',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

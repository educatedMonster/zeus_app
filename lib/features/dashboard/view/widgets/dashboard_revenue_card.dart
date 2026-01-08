import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/constants/app_text_styles.dart';

import '../../../../core/utils/extensions.dart';

class DashboardRevenueCard extends StatelessWidget {
  const DashboardRevenueCard({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();

    return Container(
      width: context.contextWidth(),
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0).r,
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
                    style: defaultTitleTextStyle(colorScheme),
                  ),
                  Text('524,000.00', style: mediumTitleTextStyle(colorScheme)),
                ],
              ),

              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Revenue PAR',
                    style: defaultTitleTextStyle(colorScheme),
                  ),
                  Text('15,000.00', style: mediumTitleTextStyle(colorScheme)),
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
                    style: defaultTitleTextStyle(colorScheme),
                  ),
                  Text('24%', style: mediumTitleTextStyle(colorScheme)),
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
                    onPressed: () async {},
                    child: Text(
                      'View Full Report',
                      style: mediumTitleTextStyle(colorScheme),
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

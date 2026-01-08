import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../../../../../core/constants/app_text_styles.dart';

class ViewReportPosSalesCard extends StatelessWidget {
  final String type;
  final bool isPositive;

  const ViewReportPosSalesCard({
    super.key,
    required this.type,
    required this.isPositive,
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
        color: type == 'Sales' ? colorScheme.primary : Colors.orange,
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
              Row(
                spacing: 4.0.r,
                children: [
                  Icon(
                    Icons.storage,
                    color: colorScheme.surface,
                    size: 16.0.r,
                  ),
                  Text(
                    'Net Sales',
                    style: titlePOSTextStyle(colorScheme.onPrimary),
                  ),
                ],
              ),
              Text(
                'last week',
                style: captionPOSTextStyle(colorScheme.onPrimary),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: .center,
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                '69,600.00',
                style: salesPOSTextStyle(colorScheme.onPrimary)
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 8.0,
                ).r,
                decoration: BoxDecoration(
                  color: isPositive ? Colors.green : Colors.red,
                  // Green background for the percentage
                  borderRadius: BorderRadius.circular(100.0).r,
                ),
                child: Row(
                  spacing: 4.0.r,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: colorScheme.surface,
                      size: 16.0.r,
                    ),
                    Text(
                      '+8.2%',
                      style: percentPOSTextStyle(colorScheme.onPrimary),
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

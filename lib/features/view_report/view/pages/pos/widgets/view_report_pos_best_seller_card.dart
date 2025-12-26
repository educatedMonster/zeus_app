import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/build_header_chart.dart';

class ViewReportPosBestSellerCard extends StatelessWidget {
  const ViewReportPosBestSellerCard({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();

    final List<Map<String, dynamic>> items = [
      {'name': 'French Fries', 'amount': 3500.00},
      {'name': 'Ginger Glazed', 'amount': 2500.00},
      {'name': 'Hickory Barbeque', 'amount': 1500.00},
      {'name': 'Honey Mustard', 'amount': 800.00},
      {'name': 'Mashed Potato', 'amount': 350.00},
    ];

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
        children: [
          /// Title and download icon
          BuildHeaderChart(
            label: 'Best Sellers',
            icon: Icon(Icons.download_rounded, size: 22.0.sp),
            onIconPressed: () {
              debugPrint('Download icon pressed');
            },
          ),

          SizedBox(height: 16.0.r),

          ...items.asMap().entries.map((entry) {
            int index = entry.key + 1;
            var item = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0).r,
              child: Row(
                spacing: 8.0.r,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: colorScheme.primary,
                    child: Text(
                      '$index',
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 10.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Text(
                    item['amount'].toStringAsFixed(2),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0.sp,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

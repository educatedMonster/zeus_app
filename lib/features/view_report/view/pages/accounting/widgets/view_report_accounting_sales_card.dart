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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 8.0.r,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'last week',
                style: TextStyle(
                  color: colorScheme.secondary,
                  fontSize: 10.0.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0).r,
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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/app/routes/approuter.gr.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class ReportPropertyCard extends StatelessWidget {
  final String title;

  const ReportPropertyCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();

    final List<Map<String, dynamic>> reports = [
      {'name': 'Rooms', 'value': '43.5k'},
      {'name': 'Banquet', 'value': '22.3k'},
      {'name': 'POS', 'value': '12.3k'},
      {'name': 'Accounting', 'value': null},
      {'name': 'Timekeeping', 'value': null},
    ];

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 8.0).r,
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
        spacing: 8.0.r,
        children: [
          /// Header Row
          Row(
            spacing: 8.0.r,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0).r,
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.apartment_rounded,
                  color: colorScheme.onSurface,
                  size: 20.0.r,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),

          /// Report Items
          ...reports.map(
            (report) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0).r,
              child: Row(
                children: [
                  /// Left side (name + optional trend)
                  Expanded(
                    child: Row(
                      spacing: 8.0.r,
                      children: [
                        Text(
                          report['name'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        if (report['value'] != null) ...[
                          Icon(
                            Icons.trending_up_rounded,
                            color: Colors.green,
                            size: 14.sp,
                          ),
                          Text(
                            report['value'],
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  /// Right side (button)
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side:  BorderSide(color: colorScheme.onSurface),
                      backgroundColor: colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                    ),
                    onPressed: () {
                      if (report.values.contains('Rooms')) {
                        // context.router.pushPath('/view-report-room');
                        context.router.navigate(ViewReportRoomRoute());
                      } else if (report.values.contains('Banquet')) {
                        // context.router.pushPath('/view-report-banquet');
                        context.router.navigate(ViewReportBanquetRoute());
                      } else if (report.values.contains('POS')) {
                        // context.router.pushPath('/view-report-pos');
                        context.router.navigate(ViewReportPosRoute());
                      } else if (report.values.contains('Accounting')) {
                        // context.router.pushPath('/view-report-accounting');
                        context.router.navigate(ViewReportAccountingRoute());
                      } else if (report.values.contains('Timekeeping')) {
                        // context.router.pushPath('/view-report-timekeeping');
                        context.router.navigate(ViewReportTimekeepingRoute());
                      }
                    },
                    child: Text(
                      Constants.titleViewReport,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.surface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

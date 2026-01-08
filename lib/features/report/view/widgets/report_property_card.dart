import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/app/routes/approuter.gr.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/extensions.dart';

class ReportPropertyCard extends StatelessWidget {
  final String property;

  const ReportPropertyCard({super.key, required this.property});

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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0).r,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.0).r,
        boxShadow: [
          BoxShadow(
            color: colorScheme.surfaceContainer.withValues(alpha: 0.10),
            blurRadius: 10.0.r,
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
                padding: const EdgeInsets.all(4.0).r,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(8.0).r,
                ),
                child: Icon(
                  Icons.apartment_rounded,
                  color: colorScheme.onSurface.withValues(alpha: 0.50),
                  size: 20.0.r,
                ),
              ),
              Text(
                property,
                style: cardTitleTextStyle(colorScheme),
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
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          report['name'],
                          style: mediumTitleTextStyle(colorScheme),
                        ),

                        if (report['value'] != null) ...[
                          Row(
                            spacing: 4.0.r,
                            children: [
                              Icon(
                                Icons.trending_up_rounded,
                                color: Colors.green,
                                size: 16.0.r,
                              ),
                              Text(
                                report['value'],
                                style: captionReportTextStyle(colorScheme),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  /// Right side (button)
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side:  BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.10)),
                      backgroundColor: colorScheme.surfaceContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0).r,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0).r,
                    ),
                    onPressed: () {
                      if (report.values.contains('Rooms')) {
                        // context.router.pushPath('/view-report-room');
                        context.router.navigate(ViewReportRoomRoute(property: property, module: report['name']));
                      } else if (report.values.contains('Banquet')) {
                        // context.router.pushPath('/view-report-banquet');
                        context.router.navigate(ViewReportBanquetRoute(property: property, module: report['name']));
                      } else if (report.values.contains('POS')) {
                        // context.router.pushPath('/view-report-pos');
                        context.router.navigate(ViewReportPosRoute(property: property, module: report['name']));
                      } else if (report.values.contains('Accounting')) {
                        // context.router.pushPath('/view-report-accounting');
                        context.router.navigate(ViewReportAccountingRoute(property: property, module: report['name']));
                      } else if (report.values.contains('Timekeeping')) {
                        // context.router.pushPath('/view-report-timekeeping');
                        context.router.navigate(ViewReportTimekeepingRoute());
                      }
                    },
                    child: Text(
                      Constants.titleViewReport,
                      style: viewReportTextStyle(colorScheme),
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

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/animated_revenue_pie_chart.dart';
import '../../../../../../shared/widgets/build_header_chart.dart';
import '../../../../../../shared/widgets/build_legend_dot.dart';
import '../../../../../dashboard/data/sources/remote/model/pie_chart_section_model.dart';

class ViewReportBanquetBusinessSourceCard extends StatelessWidget {
  final String parentKeyAnimation;
  final String childKeyAnimation;
  final List<PieChartSectionModel> pieChartSectionModelList;

  const ViewReportBanquetBusinessSourceCard({
    super.key,
    required this.parentKeyAnimation,
    required this.childKeyAnimation,
    required this.pieChartSectionModelList,
  });

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
            color: colorScheme.surfaceContainer.withValues(alpha: 0.10),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Dynamically size the chart based on card width
          final chartSize = constraints.maxWidth * 0.40; // 45% of card width

          return Column(
            crossAxisAlignment: .start,
            spacing: 16.0.r,
            children: [
              /// Title and download icon
              BuildHeaderChart(
                label: 'Production by Business Source',
                icon: Icon(Icons.download_rounded, size: 22.sp),
                onIconPressed: () {
                  debugPrint('Download icon pressed');
                },
              ),

              /// Chart and Legend
              Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .center,
                children: [
                  /// Legend Section
                  Column(
                    crossAxisAlignment: .start,
                    spacing: 8.0.r,
                    children: [
                      BuildLegendDot(color: Colors.red, label: 'Email'),
                      BuildLegendDot(color: Colors.blue, label: 'Website'),
                      BuildLegendDot(color: Colors.orange, label: 'Phone Call'),
                      BuildLegendDot(color: Colors.green, label: 'Expo'),
                      BuildLegendDot(color: Colors.indigo, label: 'Social'),
                      BuildLegendDot(color: Colors.brown, label: 'Others'),
                    ],
                  ),

                  /// Pie Chart (dynamic size)
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.0.r,
                      vertical: 24.0.r,
                    ),
                    height: chartSize,
                    width: chartSize,
                    child: AnimatedRevenuePieChart(
                      keyAnimation:
                      '$parentKeyAnimation-$childKeyAnimation-view_report_banquet_business_source_card',
                      sections: pieChartSectionModelList,
                      chartSize: chartSize,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/animated_revenue_pie_chart.dart';
import '../../../../shared/widgets/build_legend_dot.dart';
import '../../data/sources/remote/model/pie_chart_section_model.dart';

class DashboardRevenueBreakdownCard extends StatelessWidget {
  final String parentKeyAnimation;
  final String childKeyAnimation;
  final List<PieChartSectionModel> pieChartSectionModelList;

  const DashboardRevenueBreakdownCard({
    super.key,
    required this.parentKeyAnimation,
    required this.childKeyAnimation,
    required this.pieChartSectionModelList,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();
    // int touchedIndex = 0;

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Dynamically size the chart based on card width
          final chartSize = constraints.maxWidth * 0.45; // 45% of card width

          return Column(
            crossAxisAlignment: .start,
            spacing: 16.0.r,
            children: [
              /// Title
              Text(
                'Revenue Breakdown',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),

              /// Chart and Legend
              Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .center,
                children: [
                  /// Legend Section
                  Column(
                    crossAxisAlignment: .start,
                    children: List.generate(pieChartSectionModelList.length, (
                      index,
                    ) {
                      final section = pieChartSectionModelList[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.0.r),
                        child: InkWell(
                          // onTapDown: (_) => setState(() => touchedIndex = index), // TODO: You can use provider to store the index
                          // onTapUp: (_) => setState(() => touchedIndex = -1), // TODO: You can use provider to store the index
                          child: BuildLegendDot(
                            color: section.color,
                            label: section.title,
                          ),
                        ),
                      );
                    }),
                  ),

                  /// Animated Pie Chart
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.0.r,
                      vertical: 24.0.r,
                    ),
                    width: chartSize,
                    height: chartSize,
                    child: AnimatedRevenuePieChart(
                      keyAnimation:
                          '$parentKeyAnimation-$childKeyAnimation-dashboard_revenue_breakdown_card',
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

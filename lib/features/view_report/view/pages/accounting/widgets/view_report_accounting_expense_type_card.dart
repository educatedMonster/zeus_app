import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/animated_revenue_pie_chart.dart';
import '../../../../../../shared/widgets/build_legend_dot.dart';
import '../../../../../dashboard/data/sources/remote/model/pie_chart_section_model.dart';

class ViewReportAccountingExpenseTypeCard extends StatelessWidget {
  final String parentKeyAnimation;
  final String childKeyAnimation;
  final List<PieChartSectionModel> pieChartSectionModelList;

  const ViewReportAccountingExpenseTypeCard({
    super.key,
    required this.parentKeyAnimation,
    required this.childKeyAnimation,
    required this.pieChartSectionModelList,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    Size size = context.contextSize();

    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 4.0.r),
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
          final chartSize = constraints.maxWidth * 0.50;

          return Column(
            crossAxisAlignment: .start,
            spacing: 16.0.r,
            children: [
              /// Title and download icon
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Expense Type / Account',
                      style: cardTitleTextStyle(colorScheme),
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {},
                    icon: iconDownload(),
                  ),
                ],
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
                    children: List.generate(pieChartSectionModelList.length, (
                        index,
                        ) {
                      PieChartSectionModel section = pieChartSectionModelList[index];

                      return InkWell(
                        // onTapDown: (_) => setState(() => touchedIndex = index), // TODO: You can use provider to store the index
                        // onTapUp: (_) => setState(() => touchedIndex = -1), // TODO: You can use provider to store the index
                        child: BuildLegendDot(
                          color: section.color,
                          label: section.title,
                        ),
                      );
                    }),
                  ),

                  /// Pie Chart (dynamic size)
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.0.r,
                        vertical: 24.0.r,
                      ),
                      height: chartSize,
                      width: chartSize,
                      child: AnimatedRevenuePieChart(
                        keyAnimation:
                        '$parentKeyAnimation-$childKeyAnimation-view_report_accounting_expense_type_card',
                        sections: pieChartSectionModelList,
                        chartSize: chartSize,
                      ),
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

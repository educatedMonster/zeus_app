import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/animated_income_expense_bar_chart.dart';
import '../../../../../../shared/widgets/build_header_chart.dart';
import '../../../../../../shared/widgets/build_legend_dot.dart';
import '../../../../data/sources/remote/model/finance_bar_data_model.dart';

class ViewReportAccountingIncomeExpenseChart extends StatelessWidget {
  final String parentKeyAnimation;
  final String childKeyAnimation;
  final List<FinanceBarDataModel> financeBarDataModelList;

  const ViewReportAccountingIncomeExpenseChart({
    super.key,
    required this.parentKeyAnimation,
    required this.childKeyAnimation,
    required this.financeBarDataModelList,
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
            children: [
              /// Title and download icon
              BuildHeaderChart(
                label: 'Income and Expense',
                icon: iconDownload(),
                onIconPressed: () async {
                  debugPrint('Download icon pressed');
                },
              ),

              /// Chart
              financeBarDataModelList.isEmpty
                  ? SizedBox(
                      height: chartSize,
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8.0.r,
                        children: [
                          Icon(
                            Icons.bar_chart,
                            color: colorScheme.onSurface,
                            size: 32.0.r,
                          ),
                          Text(
                            'No data available',
                            style: largeTitleTextStyle(colorScheme),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: .start,
                      children: [
                        /// Legend
                        SingleChildScrollView(
                          scrollDirection: .horizontal,
                          child: Row(
                            spacing: 16.0.r,
                            children: [
                              BuildLegendDot(
                                color: Colors.blue,
                                label: 'Income',
                              ),
                              BuildLegendDot(
                                color: Colors.orange,
                                label: 'Expense',
                              ),
                              // Add more if needed
                            ],
                          ),
                        ),

                        /// Chart
                        SingleChildScrollView(
                          scrollDirection: .horizontal,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 8.0.r,
                              vertical: 16.0.r,
                            ),
                            height: chartSize,
                            width: size.width,
                            child: AnimatedIncomeExpenseBarChart(
                              keyAnimation:
                                  '$parentKeyAnimation-$childKeyAnimation-view_report_accounting_income_expense_chart',
                              list: financeBarDataModelList,
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

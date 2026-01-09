import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/features/view_report/data/sources/remote/model/cash_in_out_bar_data_model.dart';

import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/animated_cash_in_out_bar_chart.dart';
import '../../../../../../shared/widgets/build_header_chart.dart';
import '../../../../../../shared/widgets/build_legend_dot.dart';

class ViewReportAccountingCashInOutChart extends StatelessWidget {
  final String parentKeyAnimation;
  final String childKeyAnimation;
  final List<CashInOutBarDataModel> cashInOutBarDataModelList;

  const ViewReportAccountingCashInOutChart({
    super.key,
    required this.parentKeyAnimation,
    required this.childKeyAnimation,
    required this.cashInOutBarDataModelList,
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
                label: 'Total cash in and out',
                icon: iconDownload(),
                onIconPressed: () {
                  debugPrint('Download icon pressed');
                },
              ),

              /// Chart
              cashInOutBarDataModelList.isEmpty
                  ? SizedBox(
                      height: chartSize,
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: .center,
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
                      spacing: 24.0.r,
                      children: [
                        /// Legend
                        SingleChildScrollView(
                          scrollDirection: .horizontal,
                          child: Row(
                            spacing: 16.0.r,
                            children: [
                              BuildLegendDot(
                                color: Colors.blue,
                                label: 'Cash in',
                              ),
                              BuildLegendDot(
                                color: Colors.orange,
                                label: 'Cash out',
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
                            child: AnimatedCashInOutBarChart(
                              keyAnimation:
                                  '$parentKeyAnimation-$childKeyAnimation-view_report_accounting_cash_in_out_chart',
                              list: cashInOutBarDataModelList,
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

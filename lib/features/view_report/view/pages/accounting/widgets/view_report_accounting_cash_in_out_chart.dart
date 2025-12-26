import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/features/view_report/data/sources/remote/model/cash_in_out_bar_data_model.dart';

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
              BuildHeaderChart(
                label: 'Total cash in and out',
                icon: Icon(Icons.download_rounded, size: 22.0.sp),
                onIconPressed: () {
                  debugPrint('Download icon pressed');
                },
              ),

              /// Chart
              cashInOutBarDataModelList.isEmpty
                  ? SizedBox(
                      height: chartSize,
                      width: width,
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
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 12.0.sp,
                            ),
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
                            width: width,
                            child: AnimatedCashInOutBarChart(
                              keyAnimation:
                                  '$parentKeyAnimation-$childKeyAnimation-view_report_accounting_cash_in_out_chart',
                              list: cashInOutBarDataModelList,
                            ),
                            // child: BarChart(
                            //   BarChartData(
                            //     gridData: FlGridData(
                            //       show: true,
                            //       drawVerticalLine: false,
                            //       getDrawingHorizontalLine: (value) => FlLine(
                            //         color: Colors.grey.withValues(alpha: 0.2),
                            //         strokeWidth: 1,
                            //       ),
                            //     ),
                            //     borderData: FlBorderData(show: false),
                            //     titlesData: FlTitlesData(
                            //       leftTitles: AxisTitles(
                            //         sideTitles: SideTitles(
                            //           showTitles: true,
                            //           reservedSize: 40.0.r,
                            //           interval: 200000,
                            //           getTitlesWidget: (value, meta) {
                            //             if (value == 0)
                            //               return Text(
                            //                 '0',
                            //                 style: axisTextStyle(),
                            //               );
                            //             if (value == 200000)
                            //               return Text(
                            //                 '200K',
                            //                 style: axisTextStyle(),
                            //               );
                            //             if (value == 400000)
                            //               return Text(
                            //                 '400K',
                            //                 style: axisTextStyle(),
                            //               );
                            //             return const SizedBox.shrink();
                            //           },
                            //         ),
                            //       ),
                            //       rightTitles: const AxisTitles(
                            //         sideTitles: SideTitles(showTitles: false),
                            //       ),
                            //       topTitles: const AxisTitles(
                            //         sideTitles: SideTitles(showTitles: false),
                            //       ),
                            //       bottomTitles: AxisTitles(
                            //         sideTitles: SideTitles(
                            //           showTitles: true,
                            //           interval: 1,
                            //           getTitlesWidget: (value, meta) {
                            //             final labels = ['14', '15', '16', '17'];
                            //             if (value.toInt() < labels.length) {
                            //               return Text(
                            //                 labels[value.toInt()],
                            //                 style: axisTextStyle(),
                            //               );
                            //             }
                            //             return const SizedBox.shrink();
                            //           },
                            //         ),
                            //       ),
                            //     ),
                            //     barGroups: [
                            //       _makeGroupData(0, 200000, 100000),
                            //       _makeGroupData(1, 180000, 120000),
                            //       _makeGroupData(2, 300000, 250000),
                            //       _makeGroupData(3, 180000, 80000),
                            //     ],
                            //     barTouchData: BarTouchData(
                            //       enabled: true,
                            //       touchTooltipData: BarTouchTooltipData(
                            //         tooltipMargin: 8.0.r,
                            //         getTooltipColor: (group) => Colors.white,
                            //         tooltipBorderRadius: BorderRadius.circular(
                            //           8.r,
                            //         ),
                            //         tooltipPadding: EdgeInsets.all(8.0.r),
                            //         getTooltipItem:
                            //             (group, groupIndex, rod, rodIndex) {
                            //               return BarTooltipItem(
                            //                 '${rod.toY.toStringAsFixed(0)}.00',
                            //                 TextStyle(
                            //                   color: Colors.black87,
                            //                   fontWeight: FontWeight.w600,
                            //                   fontSize: 13.sp,
                            //                 ),
                            //               );
                            //             },
                            //       ),
                            //     ),
                            //   ),
                            // ),
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

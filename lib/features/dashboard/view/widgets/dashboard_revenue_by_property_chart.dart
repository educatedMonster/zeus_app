import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/animated_revenue_bar_chart.dart';
import '../../../../shared/widgets/build_header_chart.dart';
import '../../../../shared/widgets/build_legend_dot.dart';
import '../../../view_report/data/sources/remote/model/revenue_data_model.dart';

class DashboardRevenueByPropertyChart extends StatelessWidget {
  final String parentKeyAnimation;
  final String childKeyAnimation;
  final List<RevenueDataModel> revenueBarDataModelList;

  const DashboardRevenueByPropertyChart({
    super.key,
    required this.parentKeyAnimation,
    required this.childKeyAnimation,
    required this.revenueBarDataModelList,
  });

  @override
  Widget build(BuildContext context) {
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Dynamically size the chart based on card width
          final chartSize = constraints.maxWidth * 0.60; // 45% of card width

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24.0.r,
            children: [
              /// Title and download icon
              BuildHeaderChart(
                label: 'Revenue by Property',
                icon: Icon(Icons.download_rounded, size: 22.sp),
                onIconPressed: () {
                  debugPrint('Download icon pressed');
                },
              ),

              /// Chart
              revenueBarDataModelList.isEmpty
                  ? SizedBox(
                      height: chartSize,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8.0.r,
                        children: [
                          Icon(Icons.bar_chart, color: Colors.grey, size: 48),
                          const Text(
                            'No data available',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        /// Legend
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 16.0.r,
                            children: [
                              BuildLegendDot(
                                color: Colors.blue,
                                label: 'Property A',
                              ),
                              BuildLegendDot(
                                color: Colors.orange,
                                label: 'Property B',
                              ),
                              BuildLegendDot(
                                color: Colors.teal,
                                label: 'Property C',
                              ),
                              // Add more if needed
                            ],
                          ),
                        ),

                        /// Chart
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 200.0.r,
                            child: AnimatedRevenueBarChart(
                              keyAnimation:
                                  '$parentKeyAnimation-$childKeyAnimation-dashboard_revenue_by_property_chart',
                              list: revenueBarDataModelList,
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
                            //               return Text('0', style: axisTextStyle());
                            //             if (value == 200000)
                            //               return Text('200K', style: axisTextStyle());
                            //             if (value == 400000)
                            //               return Text('400K', style: axisTextStyle());
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
                            //       make3GroupData(0, 200000, 100000, 150000),
                            //       make3GroupData(1, 180000, 120000, 200000),
                            //       make3GroupData(2, 300000, 250000, 220000),
                            //       make3GroupData(3, 180000, 80000, 190000),
                            //     ],
                            //     barTouchData: BarTouchData(
                            //       enabled: true,
                            //       touchTooltipData: BarTouchTooltipData(
                            //         tooltipMargin: 8.0.r,
                            //         getTooltipColor: (group) => Colors.white,
                            //         tooltipBorderRadius: BorderRadius.circular(8.r),
                            //         tooltipPadding: EdgeInsets.all(8.0.r),
                            //         getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            //           return BarTooltipItem(
                            //             '${rod.toY.toStringAsFixed(0)}.00',
                            //             TextStyle(
                            //               color: Colors.black87,
                            //               fontWeight: FontWeight.w600,
                            //               fontSize: 13.sp,
                            //             ),
                            //           );
                            //         },
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

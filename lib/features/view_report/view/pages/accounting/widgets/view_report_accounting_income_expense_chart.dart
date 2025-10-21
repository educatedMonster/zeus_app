import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/widgets/animated_bar_chart.dart';

class ViewReportAccountingIncomeExpenseChart extends StatelessWidget {
  const ViewReportAccountingIncomeExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barGroups = [
      _makeGroupData(0, 200000, 100000),
      _makeGroupData(1, 180000, 120000),
      _makeGroupData(2, 300000, 250000),
      _makeGroupData(3, 180000, 80000),
    ];

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Income and Expense',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.download_rounded, size: 22.sp),
                  ),
                ],
              ),

              /// Legend
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 16.0.r,
                  children: [
                    _buildLegendDot(Colors.blue, 'Income'),
                    _buildLegendDot(Colors.orange, 'Expense'),
                    // Add more if needed
                  ],
                ),
              ),

              /// Chart
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 8.0.r,
                    vertical: 16.0.r,
                  ),
                  height: chartSize,
                  width: MediaQuery.of(context).size.width,
                  child: AnimatedBarChart(),
                  // child: BarChart(
                  //   duration: const Duration(milliseconds: 500),
                  //   curve: Curves.easeInOut,
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
                  //     barGroups: barGroups,
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
          );
        },
      ),
    );
  }

  /// Helper for legend dot
  Widget _buildLegendDot(Color color, String label) {
    return Row(
      spacing: 8.0.r,
      children: [
        Container(
          width: 10.0.r,
          height: 10.0.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 13.sp, color: Colors.black87),
        ),
      ],
    );
  }

  /// Helper for group bars
  BarChartGroupData _makeGroupData(int x, double a, double b) {
    return BarChartGroupData(
      x: x,
      barsSpace: 1.0.r,
      barRods: [
        BarChartRodData(
          toY: a,
          color: Colors.indigo,
          width: 25.0.r,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r),
            topRight: Radius.circular(4.r),
          ),
        ),
        BarChartRodData(
          toY: b,
          color: Colors.orange,
          width: 25.0.r,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r),
            topRight: Radius.circular(4.r),
          ),
        ),
      ],
    );
  }
}

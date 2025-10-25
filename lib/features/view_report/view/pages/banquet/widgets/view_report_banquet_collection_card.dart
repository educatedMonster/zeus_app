import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../shared/widgets/build_header_chart.dart';
import '../../../../../../shared/widgets/build_legend_dot.dart';

class ViewReportBanquetCollectionCard extends StatelessWidget {
  const ViewReportBanquetCollectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final barData = [
      _makeStackedGroupData(0, cash: 200000, card: 100000, others: 150000),
      _makeStackedGroupData(1, cash: 180000, card: 120000, others: 100000),
      _makeStackedGroupData(2, cash: 300000, card: 250000, others: 220000),
      _makeStackedGroupData(3, cash: 180000, card: 80000, others: 190000),
    ];

    final maxY = barData
        .map((group) => group.barRods.first.toY)
        .reduce((a, b) => a > b ? a : b);

    final chartHeight = (maxY / 2).h.clamp(
      200.h,
      250.h,
    ); // Adjust scale as needed

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24.0.r,
        children: [
          /// Title and download icon
          BuildHeaderChart(
            label: 'Total Collection per Date',
            icon: Icon(Icons.download_rounded, size: 22.sp),
            onIconPressed: () {
              debugPrint('Download icon pressed');
            },
          ),

          /// Legend
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 16.0.r,
              children: [
                BuildLegendDot(color: Colors.red, label: 'Cash'),
                BuildLegendDot(color: Colors.orange, label: 'Card'),
                BuildLegendDot(color: Colors.teal, label: 'Others'),
                BuildLegendDot(color: Colors.indigo, label: 'Total'),
              ],
            ),
          ),

          /// Chart
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: 200.h,
              height: chartHeight,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.withValues(alpha: 0.2),
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40.0.r,
                        interval: 200000,
                        getTitlesWidget: (value, meta) {
                          if (value == 0)
                            return Text('0', style: axisTextStyle());
                          if (value == 200000)
                            return Text('200K', style: axisTextStyle());
                          if (value == 400000)
                            return Text('400K', style: axisTextStyle());
                          if (value == 600000)
                            return Text('600K', style: axisTextStyle());
                          if (value == 800000)
                            return Text('800K', style: axisTextStyle());
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final labels = ['14', '15', '16', '17'];
                          if (value.toInt() < labels.length) {
                            return Text(
                              labels[value.toInt()],
                              style: axisTextStyle(),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  barGroups: barData,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipMargin: 1.0.r,
                      getTooltipColor: (group) => Colors.black12,
                      tooltipBorderRadius: BorderRadius.circular(8.r),
                      tooltipPadding: EdgeInsets.all(8.0.r),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${rod.rodStackItems[0].label} - ${rod.rodStackItems[0].toY.toStringAsFixed(0)}.00\n'
                          '${rod.rodStackItems[1].label} - ${rod.rodStackItems[1].toY.toStringAsFixed(0)}.00\n'
                          '${rod.rodStackItems[2].label} - ${rod.rodStackItems[2].toY.toStringAsFixed(0)}.00\n'
                          '${rod.rodStackItems[3].label} - ${rod.rodStackItems[3].toY.toStringAsFixed(0)}.00',
                          TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.0.sp,
                          ),
                          textAlign: TextAlign.start,
                        );
                      },
                    ),
                  ),
                ),
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInOut,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper for stacked group bar data
  BarChartGroupData _makeStackedGroupData(
    int x, {
    required double cash,
    required double card,
    required double others,
  }) {
    final double total = cash + card + others;
    final double toY = total + (total * 0.50);

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: toY,
          width: 30.0.r,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r),
            topRight: Radius.circular(4.r),
          ),
          rodStackItems: [
            BarChartRodStackItem(
              label: 'Cash',
              labelStyle: TextStyle(color: Colors.red, fontSize: 0.0.sp),
              0,
              cash,
              Colors.red,
            ),
            BarChartRodStackItem(
              label: 'Card',
              labelStyle: TextStyle(color: Colors.orange, fontSize: 0.0.sp),
              cash,
              cash + card,
              Colors.orange,
            ),
            BarChartRodStackItem(
              label: 'Others',
              labelStyle: TextStyle(color: Colors.teal, fontSize: 0.0.sp),
              cash + card,
              total,
              Colors.teal,
            ),
            BarChartRodStackItem(
              label: 'Total',
              labelStyle: TextStyle(color: Colors.indigo, fontSize: 0.0.sp),
              total,
              toY,
              Colors.indigo,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/utils/number_formatter.dart';

class ByHourView extends StatelessWidget {
  final ColorScheme colorScheme;
  final double width;
  final List<double> data;
  final List<String> labels;

  const ByHourView({
    super.key,
    required this.colorScheme,
    required this.width,
    required this.data,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      // physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // width: data.length * 60.w,
        width: width,
        child: BarChart(
          BarChartData(
            gridData: FlGridData(show: true, drawVerticalLine: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32.0.r,
                  getTitlesWidget: (value, meta) {
                    if (value % 1000 != 0) return const SizedBox.shrink();
                    return Text(
                      formatNumber(value),
                      style: axisTextStyle(colorScheme),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= labels.length) {
                      return const SizedBox.shrink();
                    }
                    return Text(
                      labels[index],
                      style: axisTextStyle(colorScheme),
                    );
                  },
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            barGroups: List.generate(data.length, (i) {
              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: data[i],
                    color: colorScheme.primary,
                    width: 20.0.r,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

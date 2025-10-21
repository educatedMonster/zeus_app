import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_text_styles.dart';
import '../../features/view_report/data/sources/remote/model/finance_bar_data_model.dart';

class AnimatedBarChart extends StatefulWidget {
  const AnimatedBarChart({super.key});

  @override
  State<AnimatedBarChart> createState() => _AnimatedBarChartState();
}

class _AnimatedBarChartState extends State<AnimatedBarChart>
    with SingleTickerProviderStateMixin {
  List<FinanceBarDataModel> _list = [];
  late List<BarChartGroupData> _rawBarGroups;
  late AnimationController _controller;
  late Animation<double> _animation;
  final double width = 16.0.r;
  int touchedGroupIndex = -1;
  double _maxValue = 0.0;
  double _step = 0.0;
  List<double> _averages = [];

  @override
  void initState() {
    super.initState();

    _list = [
      FinanceBarDataModel(label: '1', order: 0, a: 5, b: 2),
      FinanceBarDataModel(label: '2', order: 1, a: 16, b: 12),
      FinanceBarDataModel(label: '3', order: 2, a: 18, b: 5),
      FinanceBarDataModel(label: '4', order: 4, a: 17, b: 6),
      FinanceBarDataModel(label: '5', order: 5, a: 19, b: 1.5),
      FinanceBarDataModel(label: '6', order: 6, a: 10, b: 1.5),
      FinanceBarDataModel(label: '7', order: 7, a: 30, b: 1.5),
    ];

    _rawBarGroups = _list
        .map((e) => _makeGroupData(e.order, e.a, e.b))
        .toList();

    // Extract all toY values from bar rods in all groups
    List<double> allToYValues = _rawBarGroups
        .expand((group) => group.barRods)
        .map((rod) => rod.toY)
        .toList();

    // Find max
    _maxValue = allToYValues.reduce((curr, next) => curr > next ? curr : next);

    _step = _maxValue / 3;
    _averages = [0, _step, 2 * _step, _maxValue];

    // Setup animation controller for 1 second
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    // Start the animation
    _controller.forward();

    // Listen to animation updates and rebuild
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<BarChartGroupData> get animatedBarGroups {
    // Multiply each bar height by animation progress (0.0 to 1.0)
    return _rawBarGroups.map((group) {
      return group.copyWith(
        barRods: group.barRods.map((rod) {
          return rod.copyWith(toY: rod.toY * _animation.value);
        }).toList(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      BarChartData(
        groupsSpace: 30, // space between each BarChartGroupData
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.grey.withValues(alpha: 0.2), strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40.0.r,
              interval: 10,
              getTitlesWidget: (value, meta) {
                final labels = _averages.map((e) => e).toList();
                if (value < labels.length) {
                  return Text(
                    '${labels[value.toInt()]}',
                    style: axisTextStyle(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(reservedSize: 40.0.r, showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 10,
              getTitlesWidget: (value, meta) {
                final labels = _list.map((e) => e.label).toList();
                if (value.toInt() < labels.length) {
                  return Text(labels[value.toInt()], style: axisTextStyle());
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        barGroups: animatedBarGroups,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipMargin: 8.0.r,
            getTooltipColor: (group) => Colors.white,
            tooltipBorderRadius: BorderRadius.circular(8.r),
            tooltipPadding: EdgeInsets.all(8.0.r),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toStringAsFixed(0)}.00',
                TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              );
            },
          ),
          touchCallback: (FlTouchEvent event, response) {
            // if (response == null || response.spot == null) {
            //   setState(() {
            //     touchedGroupIndex = -1;
            //   });
            //   return;
            // }
            // touchedGroupIndex = response.spot!.touchedBarGroupIndex;
            //
            // setState(() {
            //   if (!event.isInterestedForInteractions) {
            //     touchedGroupIndex = -1;
            //     return;
            //   }
            //   if (touchedGroupIndex != -1) {
            //     var sum = 0.0;
            //     for (final rod
            //         in rawBarGroups[touchedGroupIndex].barRods) {
            //       sum += rod.toY;
            //     }
            //     final avg =
            //         sum /
            //         rawBarGroups[touchedGroupIndex].barRods.length;
            //
            //     rawBarGroups[touchedGroupIndex] =
            //         rawBarGroups[touchedGroupIndex].copyWith(
            //           barRods: rawBarGroups[touchedGroupIndex].barRods
            //               .map((rod) {
            //                 return rod.copyWith(
            //                   toY: avg,
            //                   color: Colors.grey,
            //                 );
            //               })
            //               .toList(),
            //         );
            //
            //     // Restart animation to animate the change
            //     _controller.reset();
            //     _controller.forward();
            //   }
            // });
          },
        ),
        maxY:
            _maxValue, // IMPORTANT . This will help the animation makes smoother
      ),
    );
  }

  /// Helper for group bars
  BarChartGroupData _makeGroupData(int x, double a, double b) {
    return BarChartGroupData(
      x: x,
      barsSpace: 1, // space between rods in this group
      barRods: [
        BarChartRodData(
          toY: a,
          color: Colors.indigo,
          width: 15,  // width of each rod
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r),
            topRight: Radius.circular(4.r),
          ),
        ),
        BarChartRodData(
          toY: b,
          color: Colors.orange,
          width: 15,  // width of each rod
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r),
            topRight: Radius.circular(4.r),
          ),
        ),
      ],
    );
  }
}

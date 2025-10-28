import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/constants/app_text_styles.dart';
import '../../features/view_report/data/sources/remote/model/finance_bar_data_model.dart';
import '../components/get_animated_bar_group.dart';

class AnimatedIncomeExpenseBarChart extends StatefulWidget {
  final String keyAnimation;
  final List<FinanceBarDataModel> list;

  const AnimatedIncomeExpenseBarChart({
    super.key,
    required this.list,
    required this.keyAnimation,
  });

  @override
  State<AnimatedIncomeExpenseBarChart> createState() =>
      _AnimatedIncomeExpenseBarChartState();
}

class _AnimatedIncomeExpenseBarChartState
    extends State<AnimatedIncomeExpenseBarChart>
    with TickerProviderStateMixin {
  List<FinanceBarDataModel> _list = [];
  late List<BarChartGroupData> _rawBarGroups;
  late AnimationController _barController;
  late Animation<double> _barAnimation;
  bool _hasAnimated = false; // Prevents repeating animation
  final double width = 16.0.r;
  int touchedGroupIndex = -1;
  double _maxValue = 0.0;
  double _step = 0.0;
  List<double> _averages = [];

  @override
  void initState() {
    super.initState();

    _list = widget.list;

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
    _barController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _barAnimation = CurvedAnimation(
      parent: _barController,
      curve: Curves.easeOut,
    );
  }

  void _startAnimation() {
    if (_hasAnimated) return;
    _hasAnimated = true;
    // Start the animation
    _barController.forward();

    // Listen to animation updates and rebuild
    _barController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _barController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.keyAnimation),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) {
          _startAnimation();
        }
      },
      child: BarChart(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        BarChartData(
          groupsSpace: 30,
          // space between each BarChartGroupData
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
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40.0.r,
                interval: 5,
                getTitlesWidget: (value, meta) {
                  // if (value == 0) return Text('0', style: axisTextStyle());
                  // if (value == 200000) {
                  //   return Text('200K', style: axisTextStyle());
                  // }
                  // if (value == 400000) {
                  //   return Text('400K', style: axisTextStyle());
                  // }
                  if (value == 0) return Text('0', style: axisTextStyle());
                  if (value > 0) {
                    return Text('$value', style: axisTextStyle());
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            // leftTitles: AxisTitles(
            //   sideTitles: SideTitles(
            //     showTitles: true,
            //     reservedSize: 40.0.r,
            //     interval: 10,
            //     getTitlesWidget: (value, meta) {
            //       final labels = _averages.map((e) => e).toList();
            //       if (value < labels.length) {
            //         return Text(
            //           '${labels[value.toInt()]}',
            //           style: axisTextStyle(),
            //         );
            //       }
            //       return const SizedBox.shrink();
            //     },
            //   ),
            // ),
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
          barGroups: getAnimatedBarGroups(_rawBarGroups, _barAnimation),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipMargin: 1.0.r,
              getTooltipColor: (group) => Colors.black12,
              tooltipBorderRadius: BorderRadius.circular(8.r),
              tooltipPadding: EdgeInsets.all(8.0.r),
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              direction: TooltipDirection.auto,
              tooltipHorizontalAlignment: FLHorizontalAlignment.center,
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
          width: 15, // width of each rod
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r),
            topRight: Radius.circular(4.r),
          ),
        ),
        BarChartRodData(
          toY: b,
          color: Colors.orange,
          width: 15, // width of each rod
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r),
            topRight: Radius.circular(4.r),
          ),
        ),
      ],
    );
  }
}

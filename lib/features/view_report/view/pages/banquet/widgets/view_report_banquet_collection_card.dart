import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../shared/widgets/build_header_chart.dart';
import '../../../../../../shared/widgets/build_legend_dot.dart';

class ViewReportBanquetCollectionCard extends StatefulWidget {
  const ViewReportBanquetCollectionCard({super.key});

  @override
  State<ViewReportBanquetCollectionCard> createState() =>
      _ViewReportBanquetCollectionCardState();
}

class _ViewReportBanquetCollectionCardState
    extends State<ViewReportBanquetCollectionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late List<BarChartGroupData> _rawBarGroups;
  late double _maxY;

  @override
  void initState() {
    super.initState();

    _rawBarGroups = [
      _makeStackedGroupData(0, cash: 200000, card: 100000, others: 150000),
      _makeStackedGroupData(1, cash: 180000, card: 120000, others: 100000),
      _makeStackedGroupData(2, cash: 300000, card: 250000, others: 220000),
      _makeStackedGroupData(3, cash: 180000, card: 80000, others: 190000),
    ];

    _maxY = _rawBarGroups
        .map((group) => group.barRods.first.toY)
        .reduce((a, b) => a > b ? a : b);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Animate each BarChartRodStackItem segment sequentially
  List<BarChartGroupData> getAnimatedBarGroups(
    List<BarChartGroupData> rawBarGroups,
    double progress,
  ) {
    return rawBarGroups.map((group) {
      return group.copyWith(
        barRods: group.barRods.map((rod) {
          final totalHeight = rod.toY;
          final stacks = rod.rodStackItems;
          final segmentCount = stacks.length;

          // Define intervals for each stacked segment (divide animation equally)
          final segmentDuration = 1.0 / segmentCount;

          final animatedStacks = <BarChartRodStackItem>[];

          for (int i = 0; i < stacks.length; i++) {
            final segmentStart = i * segmentDuration;
            final segmentEnd = (i + 1) * segmentDuration;

            double localProgress = ((progress - segmentStart) / segmentDuration)
                .clamp(0.0, 1.0);

            final stack = stacks[i];

            final animatedFromY = stack.fromY;
            final animatedToY =
                stack.fromY + (stack.toY - stack.fromY) * localProgress;

            // If this segment hasn't started yet, make it transparent
            final bool isSegmentVisible = progress >= segmentStart;

            animatedStacks.add(
              BarChartRodStackItem(
                animatedFromY,
                animatedToY,
                isSegmentVisible ? stack.color : Colors.white54,
                label: stack.label,
                labelStyle: stack.labelStyle,
              ),
            );
          }

          // Update top of rod based on final segment
          final lastToY = animatedStacks.last.toY;

          return rod.copyWith(toY: lastToY, rodStackItems: animatedStacks);
        }).toList(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final chartHeight = (_maxY / 2).h.clamp(200.h, 250.h);

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
          /// Header
          BuildHeaderChart(
            label: 'Total Collection per Date',
            icon: Icon(Icons.download_rounded, size: 22.sp),
            onIconPressed: () => debugPrint('Download pressed'),
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
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final animatedGroups = getAnimatedBarGroups(
                  _rawBarGroups,
                  _controller.value,
                );

                return SizedBox(
                  width: MediaQuery.of(context).size.width,
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
                      barGroups: animatedGroups,
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
                              '${rod.rodStackItems[0].label} - ${rod.rodStackItems[0].toY.toStringAsFixed(0)}.00\n'
                              '${rod.rodStackItems[1].label} - ${rod.rodStackItems[1].toY.toStringAsFixed(0)}.00\n'
                              '${rod.rodStackItems[2].label} - ${rod.rodStackItems[2].toY.toStringAsFixed(0)}.00\n'
                              '${rod.rodStackItems[3].label} - ${rod.rodStackItems[3].toY.toStringAsFixed(0)}.00',
                              TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0.sp,
                              ),
                            );
                          },
                        ),
                      ),
                      maxY: _maxY,
                    ),
                  ),
                );
              },
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
              0,
              cash,
              Colors.red,
              label: 'Cash',
              labelStyle: TextStyle(
                color: Colors.transparent,
                fontSize: 0.0.sp,
              ),
            ),
            BarChartRodStackItem(
              cash,
              cash + card,
              Colors.orange,
              label: 'Card',
              labelStyle: TextStyle(
                color: Colors.transparent,
                fontSize: 0.0.sp,
              ),
            ),
            BarChartRodStackItem(
              cash + card,
              total,
              Colors.teal,
              label: 'Others',
              labelStyle: TextStyle(
                color: Colors.transparent,
                fontSize: 0.0.sp,
              ),
            ),
            BarChartRodStackItem(
              total,
              toY,
              Colors.indigo,
              label: 'Total',
              labelStyle: TextStyle(
                color: Colors.transparent,
                fontSize: 0.0.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

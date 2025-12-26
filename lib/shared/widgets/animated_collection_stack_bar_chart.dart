import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/utils/extensions.dart';
import '../../features/view_report/data/sources/remote/model/collection_data_model.dart';
import '../components/get_animated_stack_bar_groups.dart';
import '../components/make_stacked_group_data.dart';

class AnimatedCollectionStackBarChart extends StatefulWidget {
  final String keyAnimation;
  final List<CollectionBarDataModel> collectionBarDataModelList;

  const AnimatedCollectionStackBarChart({
    super.key,
    required this.keyAnimation,
    required this.collectionBarDataModelList,
  });

  @override
  State<AnimatedCollectionStackBarChart> createState() =>
      _AnimatedCollectionStackBarChartState();
}

class _AnimatedCollectionStackBarChartState
    extends State<AnimatedCollectionStackBarChart>
    with SingleTickerProviderStateMixin {
  late ColorScheme _colorScheme;
  late Size _size;
  late AnimationController _barController;
  late Animation<double> _barAnimation;
  bool _hasAnimated = false; // Prevents repeating animation
  late List<BarChartGroupData> _rawBarGroups;
  late double _maxY;

  @override
  void initState() {
    super.initState();

    _rawBarGroups = [
      makeStackedGroupData(0, cash: 200000, card: 100000, others: 150000),
      makeStackedGroupData(1, cash: 180000, card: 120000, others: 100000),
      makeStackedGroupData(2, cash: 300000, card: 250000, others: 220000),
      makeStackedGroupData(3, cash: 180000, card: 80000, others: 190000),
    ];

    _maxY = _rawBarGroups
        .map((group) => group.barRods.first.toY)
        .reduce((a, b) => a > b ? a : b);

    _barController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
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
    final chartHeight = (_maxY / 2).h.clamp(200.h, 250.h);

    return VisibilityDetector(
      key: Key(widget.keyAnimation),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) {
          _startAnimation();
        }
      },
      child: SizedBox(
        width: _size.width,
        height: chartHeight,
        child: AnimatedBuilder(
          animation: _barController,
          builder: (context, child) {
            final animatedGroups = getAnimatedStackBarGroups(
              _rawBarGroups,
              _barAnimation,
            );
            return BarChart(
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
                    getTooltipColor: (group) => _colorScheme.onSurface,
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
                          color: _colorScheme.surface,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.0.sp,
                        ),
                      );
                    },
                  ),
                ),
                maxY: _maxY,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _colorScheme = context.contextColorScheme();
    _size = context.contextSize();
    super.didChangeDependencies();
  }
}

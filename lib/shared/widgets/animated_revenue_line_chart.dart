import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../core/constants/app_text_styles.dart';
import '../components/get_animated_spots.dart';

class AnimatedRevenueLineChart extends StatefulWidget {
  final String keyAnimation;
  final Color progressColor;
  final double containerHeight;
  final double containerWidth;
  final List<LineChartBarData> lineBarsData;

  const AnimatedRevenueLineChart({
    super.key,
    required this.keyAnimation,
    required this.progressColor,
    required this.containerHeight,
    required this.containerWidth,
    required this.lineBarsData,
  });

  @override
  State<AnimatedRevenueLineChart> createState() =>
      _AnimatedRevenueLineChartState();
}

class _AnimatedRevenueLineChartState extends State<AnimatedRevenueLineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _lineController;
  late Animation<double> _lineAnimation;
  bool _hasAnimated = false; // Prevents repeating animation

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _lineAnimation = CurvedAnimation(
      parent: _lineController,
      curve: Curves.easeOut,
    );
  }

  void _startAnimation() {
    if (_hasAnimated) return;
    _hasAnimated = true;
    _lineController.forward(from: 0);
  }

  @override
  void dispose() {
    _lineController.dispose();
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
      child: SingleChildScrollView(
        scrollDirection: .horizontal,
        physics: ScrollPhysics(),
        child: Container(
          height: widget.containerHeight,
          // width: widget.containerWidth,
          padding: const EdgeInsets.symmetric(
            horizontal: 2.0,
          ).copyWith(top: 24.0, bottom: 8.0).r,
          width: context.contextWidth(),
          child: AnimatedBuilder(
            animation: _lineAnimation,
            builder: (context, _) {
              return LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 500000,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            meta.formattedValue,
                            style: axisTextStyle(context.contextColorScheme()),
                          );
                        },
                        reservedSize: widget.containerWidth * 0.20,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = ['Apr', 'May', 'Jun', 'Jul', 'Aug'];

                          if (value.toInt() >= 0 &&
                              value.toInt() < months.length) {
                            return Text(
                              months[value.toInt()],
                              style: axisTextStyle(
                                context.contextColorScheme(),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  lineBarsData: widget.lineBarsData.map((e) {
                    if (e.spots.isNotEmpty) {
                      return e.copyWith(
                        spots: getAnimatedSpots(e.spots, _lineAnimation.value),
                      );
                    } else {
                      return e;
                    }
                  }).toList(),
                ),
                duration: Duration(milliseconds: 800), // <--- Add this
                curve: Curves.easeInOut, // <--- Optional
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zeus_app/core/utils/extensions.dart';

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
  State<AnimatedRevenueLineChart> createState() => _AnimatedRevenueLineChartState();
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
        child: SizedBox(
          height: widget.containerHeight,
          // width: widget.containerWidth,
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
                        getTitlesWidget: (value, _) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('0');
                            case 500000:
                              return const Text('0.5M');
                            case 1000000:
                              return const Text('1M');
                            case 1500000:
                              return const Text('1.5M');
                            default:
                              return const SizedBox.shrink();
                          }
                        },
                        reservedSize: widget.containerWidth * 0.20,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          switch (value) {
                            case 0:
                              return const Text('Apr');
                            case 1:
                              return const Text('May');
                            case 2:
                              return const Text('Jun');
                            case 3:
                              return const Text('Jul');
                            case 4:
                              return const Text('Aug');
                            default:
                              return const SizedBox.shrink();
                          }

                          /// BACKUP
                          // const months = [
                          //   'Apr',
                          //   'May',
                          //   'Jun',
                          //   'Jul',
                          //   'Aug',
                          // ];
                          // if (value >= 0 && value < months.length) {
                          //   return Text(months[value.toInt()]);
                          // }
                          // return const SizedBox();
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
              );
            },
          ),
        ),
      ),
    );
  }
}

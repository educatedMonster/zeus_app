import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../features/dashboard/data/sources/remote/model/pie_chart_section_model.dart';
import '../components/build_animated_pie_chart_sections.dart';

class AnimatedRevenuePieChart extends StatefulWidget {
  final String keyAnimation;
  final List<PieChartSectionModel> sections;
  final double chartSize;

  const AnimatedRevenuePieChart({
    super.key,
    required this.keyAnimation,
    required this.sections,
    required this.chartSize,
  });

  @override
  State<AnimatedRevenuePieChart> createState() =>
      _AnimatedRevenuePieChartState();
}

class _AnimatedRevenuePieChartState extends State<AnimatedRevenuePieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _pieController;
  bool _hasAnimated = false; // Prevents repeating animation
  int touchedIndex = -1;
  bool _animationDone = false;

  @override
  void initState() {
    super.initState();

    _pieController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // _controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed && !_animationDone) {
    //     _animationDone = true;
    //     debugPrint('Pie chart animation completed!');
    //     // You can call setState() or trigger something here if needed
    //   }
    // });
  }

  void _startAnimation() {
    if (_hasAnimated) return;
    _hasAnimated = true;

    // Start animation automatically when widget loads
    _pieController.forward();
  }

  @override
  void dispose() {
    _pieController.dispose();
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
      child: AnimatedBuilder(
        animation: _pieController,
        builder: (context, child) {
          final progress = _pieController.value;
          // Detect when animation finishes
          if (!_animationDone && progress == 1.0) {
            _animationDone = true;
            // This will run every frame where progress == 1.0
            debugPrint("Animation completed!");
          }

          final animatedSections = buildAnimatedPieChartSections(
            widget.sections,
            progress,
            touchedIndex,
          );

          return PieChart(
            PieChartData(
              startDegreeOffset: -90,
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              sections: animatedSections,
              centerSpaceRadius: widget.chartSize * 0.25,
              borderData: FlBorderData(show: false),
              sectionsSpace: 1.0.r,
            ),
          );
        },
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/shared/widgets/pie_chart_badge.dart';

import '../../features/dashboard/data/sources/remote/model/pie_chart_section_model.dart';

/// Animate drawing each section around the circle
List<PieChartSectionData> buildAnimatedPieChartSections(
  List<PieChartSectionModel> sections,
  double progress,
  int touchedIndex,
) {
  final total = sections.fold<double>(0, (sum, s) => sum + s.value);
  final totalAngle = 360 * progress;
  double accumulatedAngle = 0;

  final List<PieChartSectionData> animated = [];

  for (final s in sections) {
    final section = sections[sections.indexOf(s)];
    final isTouched = sections.indexOf(s) == touchedIndex;
    final fontSize = isTouched ? 10.0.sp : 8.0.sp;
    final radius = isTouched ? 60.0.r : 55.0.r;
    final widgetSize = isTouched ? 35.0.r : 30.0.r;

    final sweepAngle = (s.value / total) * 360;
    final remaining = totalAngle - accumulatedAngle;

    if (remaining <= 0) break;

    final visibleSweep = remaining.clamp(0, sweepAngle);
    final visibleValue = total * (visibleSweep / 360);

    // when progress == 1 -> animation is done
    progress == 1.0
        ? animated.add(
            PieChartSectionData(
              color: section.color,
              value: section.value,
              title: section.title,
              radius: radius,
              titleStyle: TextStyle(
                color: section.color,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
              badgeWidget: PieBadge(
                value: '${section.value}',
                size: widgetSize,
                borderColor: Colors.black87,
              ),
              badgePositionPercentageOffset: 0.90,
            ),
          )
        : animated.add(
            PieChartSectionData(
              color: s.color,
              value: visibleValue,
              title: visibleSweep > 10 ? s.badge : '',
              titleStyle: TextStyle(
                color: section.color,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
              radius: radius,
            ),
          );

    accumulatedAngle += sweepAngle;
  }

  return animated;
}

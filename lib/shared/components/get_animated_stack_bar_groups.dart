// Animate each BarChartRodStackItem segment sequentially
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<BarChartGroupData> getAnimatedStackBarGroups(
  List<BarChartGroupData> rawBarGroups,
  Animation<double> barAnimation,
  // double progress,
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

          double localProgress =
              ((barAnimation.value - segmentStart) / segmentDuration).clamp(
                0.0,
                1.0,
              );

          final stack = stacks[i];

          final animatedFromY = stack.fromY;
          final animatedToY =
              stack.fromY + (stack.toY - stack.fromY) * localProgress;

          // If this segment hasn't started yet, make it transparent
          final bool isSegmentVisible = barAnimation.value >= segmentStart;

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

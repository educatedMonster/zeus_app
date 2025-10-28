import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/animation.dart';

List<BarChartGroupData> getAnimatedBarGroups(
  List<BarChartGroupData> rawBarGroups,
  Animation<double> barAnimation,
) {
  // Multiply each bar height by animation progress (0.0 to 1.0)
  return rawBarGroups.map((group) {
    return group.copyWith(
      barRods: group.barRods.map((rod) {
        return rod.copyWith(toY: rod.toY * barAnimation.value);
      }).toList(),
    );
  }).toList();
}

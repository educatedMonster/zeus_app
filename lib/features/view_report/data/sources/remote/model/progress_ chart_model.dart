import 'dart:ui';

class ProgressChartModel {
  final bool isProgress;
  final String title;
  final double value;
  final String current;
  final String total;
  final Color progressColor;
  final Color progressBGColor;
  final Color backgroundColor;
  final Color textColor;

  ProgressChartModel({
    required this.isProgress,
    required this.title,
    required this.value,
    required this.current,
    required this.total,
    required this.progressColor,
    required this.progressBGColor,
    required this.backgroundColor,
    required this.textColor,
  });
}

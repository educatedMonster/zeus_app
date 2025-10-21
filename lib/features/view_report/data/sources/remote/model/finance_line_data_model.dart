import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FinanceLineDataModel {
  final List<FlSpot> financeSpots;
  final Color? color;
  final double barWidth;

  FinanceLineDataModel({
    required this.financeSpots,
    required this.color,
    required this.barWidth,
  });

  FinanceLineDataModel copyWith({
    List<FlSpot>? financeSpots,
    Color? color,
    double? barWidth,
  }) => FinanceLineDataModel(
    financeSpots: financeSpots ?? this.financeSpots,
    color: color ?? this.color,
    barWidth: barWidth ?? this.barWidth,
  );
}

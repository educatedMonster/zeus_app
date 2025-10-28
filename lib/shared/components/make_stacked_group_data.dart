import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Helper for stacked group bar data
BarChartGroupData makeStackedGroupData(
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
            labelStyle: TextStyle(color: Colors.transparent, fontSize: 0.0.sp),
          ),
          BarChartRodStackItem(
            cash,
            cash + card,
            Colors.orange,
            label: 'Card',
            labelStyle: TextStyle(color: Colors.transparent, fontSize: 0.0.sp),
          ),
          BarChartRodStackItem(
            cash + card,
            total,
            Colors.teal,
            label: 'Others',
            labelStyle: TextStyle(color: Colors.transparent, fontSize: 0.0.sp),
          ),
          BarChartRodStackItem(
            total,
            toY,
            Colors.indigo,
            label: 'Total',
            labelStyle: TextStyle(color: Colors.transparent, fontSize: 0.0.sp),
          ),
        ],
      ),
    ],
  );
}

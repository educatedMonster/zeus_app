import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BarChartGroupData make2GroupData(int x, double a, double b) {
  return BarChartGroupData(
    x: x,
    barsSpace: 2, // Space between rods in the same group
    barRods: [
      BarChartRodData(
        toY: a,
        color: Colors.indigo,
        width: 20, // width of each rod
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0).r,
          topRight: Radius.circular(4.0).r,
        ),
      ),
      BarChartRodData(
        toY: b,
        color: Colors.orange,
        width: 20, // width of each rod
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0).r,
          topRight: Radius.circular(4.0).r,
        ),
      ),
    ],
  );
}

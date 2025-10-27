import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BarChartGroupData make3GroupData(int x, double a, double b, double c) {
  return BarChartGroupData(
    x: x,
    barsSpace: 1, // space between rods in this group
    barRods: [
      BarChartRodData(
        toY: a,
        color: Colors.indigo,
        width: 15.0.r,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.r),
          topRight: Radius.circular(4.r),
        ),
      ),
      BarChartRodData(
        toY: b,
        color: Colors.orange,
        width: 15.0.r,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.r),
          topRight: Radius.circular(4.r),
        ),
      ),
      BarChartRodData(
        toY: c,
        color: Colors.teal,
        width: 15.0.r,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.r),
          topRight: Radius.circular(4.r),
        ),
      ),
    ],
  );
}

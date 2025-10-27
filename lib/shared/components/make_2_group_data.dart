import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BarChartGroupData make2GroupData(int x, double a, double b) {
  return BarChartGroupData(
    x: x,
    barsSpace: 1, // space between rods in this group
    barRods: [
      BarChartRodData(
        toY: a,
        color: Colors.indigo,
        width: 15, // width of each rod
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.r),
          topRight: Radius.circular(4.r),
        ),
      ),
      BarChartRodData(
        toY: b,
        color: Colors.orange,
        width: 15, // width of each rod
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.r),
          topRight: Radius.circular(4.r),
        ),
      ),
    ],
  );
}

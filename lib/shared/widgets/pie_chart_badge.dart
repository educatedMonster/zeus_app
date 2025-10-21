import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PieBadge extends StatelessWidget {
  final String value;
  final double size;
  final Color borderColor;

  const PieBadge({
    super.key,
    required this.value,
    required this.size,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            offset: const Offset(3, 3),
            blurRadius: 1,
          ),
        ],
      ),
      // padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Text(
          value,
          style: TextStyle(color: Colors.black87, fontSize: 10.0.sp),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'build_legend_dot.dart';

class BuildHeaderChart extends StatelessWidget {
  final String label;
  final Color? color;
  final String? caption;
  final Widget? icon;
  final VoidCallback? onIconPressed;

  const BuildHeaderChart({
    super.key,
    required this.label,
    this.color,
    this.caption,
    this.icon,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8.0.r,
                children: [BuildLegendDot(color: color, label: label)],
              ),
              if (caption != null)
                Text(
                  '$caption',
                  style: TextStyle(fontSize: 10.0.sp, color: Colors.black54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),

        if (icon != null) IconButton(onPressed: icon != null ? onIconPressed : null, icon: icon!),
      ],
    );
  }
}

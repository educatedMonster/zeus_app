import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/utils/extensions.dart';

class BuildLegendDot extends StatelessWidget {
  final Color? color;
  final String label;

  const BuildLegendDot({super.key, this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();

    return Row(
      spacing: 8.0.r,
      children: [
        if (color != null)
          Container(
            width: 10.0.r,
            height: 10.0.r,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        Text(
          label,
          style: color != null
              ? propertyTitleTextStyle(colorScheme)
              : cardTitleTextStyle(colorScheme),
          maxLines: 1,
          overflow: .ellipsis,
        ),
      ],
    );
  }
}

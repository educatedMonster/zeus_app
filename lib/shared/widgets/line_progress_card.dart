import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/shared/widgets/value_card.dart';

import '../../core/constants/app_fonts.dart';
import '../../core/constants/app_text_styles.dart';
import 'animated_line_progress_bar.dart';

class LineProgressCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final String keyAnimation;
  final String title;
  final Color progressColor;
  final Color progressBGColor;
  final double value;
  final String current;
  final String total;
  final Color bgColor;
  final Color textColor;

  const LineProgressCard({
    super.key,
    required this.colorScheme,
    required this.keyAnimation,
    required this.title,
    required this.progressColor,
    required this.progressBGColor,
    required this.value,
    required this.current,
    required this.total,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0).r,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0).r,
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
        spacing: 8.0.r,
        children: [
          /// TITLE
          Text(title, style: cardTitleTextStyle(colorScheme)),

          /// LABEL ROW (NAME + PERCENT)
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                '${(value * 100).toInt()}%',
                style: xlargeTitleTextStyle(colorScheme.onSurface),
              ),
              Text(
                '$current/$total',
                style: defaultTitleTextStyle(colorScheme),
              ),
            ],
          ),

          /// Progress bar
          AnimatedLineProgressBar(
            value: value,
            backgroundColor: progressBGColor,
            progressColor: progressColor,
            keyAnimation: keyAnimation,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../core/constants/app_text_styles.dart';

class StatusCard extends StatelessWidget {
  final Color statusColor;
  final String label;
  final String value;

  const StatusCard({
    super.key,
    required this.statusColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 12.0.r),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.surfaceContainer.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        spacing: 4.0.r,
        children: [
          Text(label, style: defaultTitleTextStyle(colorScheme)),
          Text(value, style: statusTextStyle(statusColor)),
        ],
      ),
    );
  }
}

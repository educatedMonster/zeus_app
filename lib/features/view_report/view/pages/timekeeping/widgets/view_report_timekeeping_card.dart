import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/line_progress_card.dart';

class ViewReportTimekeepingCard extends StatelessWidget {
  final String parentKeyAnimation;

  const ViewReportTimekeepingCard({
    super.key,
    required this.parentKeyAnimation,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();

    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0).r,
        boxShadow: [
          BoxShadow(
            color: colorScheme.surfaceContainer.withValues(alpha: 0.1),
            blurRadius: 10.0.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LineProgressCard(
        colorScheme: colorScheme,
        keyAnimation: '$parentKeyAnimation-view_report_timekeeping_body-1',
        title: 'Present',
        progressColor: Colors.orange,
        progressBGColor: Colors.orange.withValues(alpha: 0.15),
        value: 0.8,
        current: '80',
        total: '100',
        bgColor: colorScheme.surfaceContainer,
        textColor: colorScheme.onSurface,
      ),
    );
  }
}

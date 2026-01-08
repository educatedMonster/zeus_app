import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/extensions.dart';

class ApprovalHighLowButton extends StatelessWidget {
  final List<String> options;

  const ApprovalHighLowButton({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();
    String calendarView = context.watchApprovalVM().calendarView;

    return SizedBox(
      width: width,
      child: SegmentedButton<String>(
        expandedInsets: const EdgeInsets.all(8.0).r,
        segments: options
            .map(
              (tab) => ButtonSegment<String>(
                value: tab,
                // icon: Icon(Icons.calendar_view_day),
                label: Text(
                  tab,
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                tooltip: tab,
                enabled: true,
              ),
            )
            .toList(),
        selected: <String>{calendarView},
        onSelectionChanged: (Set<String> newSelection) {
          context.readApprovalVM().selectedCalendarView(newSelection.first);
        },
      ),
    );
  }
}

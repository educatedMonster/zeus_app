import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zeus_app/core/constants/app_text_styles.dart';

import '../../../../core/utils/extensions.dart';
import '../../viewmodel/approval_view_model.dart';

class ApprovalHighLowButton extends StatelessWidget {
  final List<String> options;

  const ApprovalHighLowButton({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();

    final segmentedButton = context.select<ApprovalViewModel, String>(
      (vm) => vm.segmentedButton,
    );

    return SizedBox(
      width: width,
      child: SegmentedButton<String>(
        expandedInsets: const EdgeInsets.all(8.0).r,
        segments: options
            .map(
              (tab) => ButtonSegment<String>(
                value: tab,
                // icon: Icon(Icons.calendar_view_day),
                label: Text(tab, style: mediumTitleTextStyle(colorScheme)),
                tooltip: tab,
                enabled: true,
              ),
            )
            .toList(),
        selected: <String>{segmentedButton},
        onSelectionChanged: (Set<String> newSelection) {
          context.readApprovalVM().selectedSegmentedButton(newSelection.first);
        },
      ),
    );
  }
}

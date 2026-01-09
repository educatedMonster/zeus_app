import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_text_styles.dart';

class PurchaseDialogActionButtons extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback onApproveTap;
  final VoidCallback onRejectTap;
  final VoidCallback onReturnTap;

  const PurchaseDialogActionButtons({
    super.key,
    required this.colorScheme,
    required this.onApproveTap,
    required this.onRejectTap,
    required this.onReturnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ).copyWith(bottom: 24.0).r,
      child: Column(
        spacing: 8.0.r,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            spacing: 8.0.r,
            children: [
              /// REJECT
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onRejectTap,
                  icon: rejectButton(colorScheme.onPrimary),
                  label: Text(
                    'Reject',
                    style: defaultOnPrimaryTextStyle(colorScheme.onPrimary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16.0).r,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0).r,
                    ),
                  ),
                ),
              ),

              /// APPROVE
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onApproveTap,
                  icon: approveButton(colorScheme.onPrimary),
                  label: Text(
                    'Approve',
                    style: defaultOnPrimaryTextStyle(colorScheme.onPrimary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16.0).r,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0).r,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// RETURN
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onReturnTap,
                  icon: undoButton(
                    colorScheme.onSurface.withValues(alpha: 0.50),
                  ),
                  label: Text(
                    'Return for Revision',
                    style: defaultTitleTextStyle(colorScheme),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.surface,
                    padding: const EdgeInsets.symmetric(vertical: 16.0).r,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.25.r,
                        color: colorScheme.onSurface.withValues(alpha: 0.50),
                      ),
                      borderRadius: BorderRadius.circular(8.0).r,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

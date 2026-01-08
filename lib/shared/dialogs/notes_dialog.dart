import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/extensions.dart';

class NotesDialog extends StatelessWidget {
  final String note;

  const NotesDialog({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double screenHeight = context.contextHeight();
    double screenWidth = context.contextWidth();

    return Dialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0).r,
      ),
      elevation: 0.1,
      shadowColor: colorScheme.onSurface,
      // insetPadding: const EdgeInsets.symmetric(
      //   horizontal: 24.0,
      //   vertical: 24.0,
      // ).r,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenHeight * 0.55,
          maxWidth: screenWidth,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: .start,
            spacing: 16.0.r,
            children: [
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0).r,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16.0).r,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 100,

                    /// TODO- change this to the notes length
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0).r,
                        child: Text('${index + 1} • ${note}'),
                      );
                    },
                  ),
                ),
              ),

              // Close button
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0.r),
                    ),
                    side: BorderSide(color: colorScheme.onSurface),
                    padding: const EdgeInsets.all(8.0).r,
                  ),
                  onPressed: () => context.maybePop(),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0.sp,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

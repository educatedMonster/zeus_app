import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/extensions.dart';

class RejectDialog extends StatefulWidget {
  final ColorScheme colorScheme;

  const RejectDialog({super.key, required this.colorScheme});

  @override
  State<RejectDialog> createState() => _RejectDialogState();
}

class _RejectDialogState extends State<RejectDialog> {
  final TextEditingController _textController = TextEditingController();
  final int _maxLength = 150;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = context.contextHeight();
    double screenWidth = context.contextWidth();

    return Dialog(
      backgroundColor: widget.colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0).r,
      ),
      elevation: 0.1,
      shadowColor: widget.colorScheme.onSurface,
      // insetPadding: const EdgeInsets.symmetric(
      //   horizontal: 24.0,
      //   vertical: 24.0,
      // ).r,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenHeight * 0.45,
          maxWidth: screenWidth,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: .start,
            spacing: 16.0.r,
            children: [
              Text(
                'What went wrong?',
                style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.bold),
              ),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0).r,
                  decoration: BoxDecoration(
                    color: widget.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: TextFormField(
                    controller: _textController,
                    maxLines: 10,
                    maxLength: _maxLength,
                    decoration: InputDecoration(
                      hintText: "What's your reason?",
                      counterText: '',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 12.0.sp,
                        color: widget.colorScheme.onSecondary,
                        fontWeight: FontWeight.w300,
                      ),
                      helperStyle: TextStyle(
                        fontSize: 12.0.sp,
                        color: widget.colorScheme.onSecondary,
                        fontWeight: FontWeight.w300,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 12.0.sp,
                        color: widget.colorScheme.onSurface,
                        fontWeight: FontWeight.w300,
                      ),
                      counterStyle: TextStyle(
                        fontSize: 12.0.sp,
                        color: widget.colorScheme.onSurface,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (text) => setState(() {}),
                  ),
                ),
              ),

              // Character counter
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${_textController.text.length}/$_maxLength',
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    color: widget.colorScheme.onSurface,
                  ),
                ),
              ),

              // Close button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                spacing: 8.0.r,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      side: BorderSide(color: widget.colorScheme.onSurface),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ).r,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0.sp,
                        color: widget.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0).r,
                      ),
                      side: BorderSide(color: widget.colorScheme.primary),
                      backgroundColor: widget.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ).r,
                    ),
                    onPressed: () {
                      final reason = _textController.text.trim();
                      if (reason.isNotEmpty) {
                        Navigator.pop(context, reason);
                      }
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0.sp,
                        color: widget.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

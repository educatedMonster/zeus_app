import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RejectDialog extends StatefulWidget {
  const RejectDialog({super.key});

  @override
  State<RejectDialog> createState() => _RejectDialogState();
}

class _RejectDialogState extends State<RejectDialog> {
  final TextEditingController _controller = TextEditingController();
  final int _maxLength = 150;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      // insetPadding: const EdgeInsets.symmetric(
      //   horizontal: 24.0,
      //   vertical: 24.0,
      // ).r,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.45,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: .start,
            spacing: 16.0.r,
            children: [
              Text(
                'What went wrong?',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0).r,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F9FB),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    maxLines: 10,
                    maxLength: _maxLength,
                    decoration: InputDecoration(
                      hintText: "What's your reason?",
                      counterText: '',
                      border: InputBorder.none,
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
                  '${_controller.text.length}/$_maxLength',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
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
                      side: BorderSide(color: Colors.grey.shade300),
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
                        fontSize: 12.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      side: BorderSide(color: Colors.indigo),
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ).r,
                    ),
                    onPressed: () {
                      final reason = _controller.text.trim();
                      if (reason.isNotEmpty) {
                        Navigator.pop(context, reason);
                      }
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: Colors.white,
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

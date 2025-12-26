import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesDialog extends StatelessWidget {
  final String note;

  const NotesDialog({super.key, required this.note});

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
          maxHeight: MediaQuery.of(context).size.height * 0.55,
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
                'Notes',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0).r,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F9FB),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 100,

                    /// TODO- change this to the notes length
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0).r,
                        child: Text('• ${note}'),
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
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: const EdgeInsets.all(8.0).r,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: Colors.black87,
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

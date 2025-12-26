import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'reject_dialog.dart';
import 'show_history_dialog.dart';

class PurchaseRequestDialog extends StatelessWidget {
  const PurchaseRequestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.80,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ).r,
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 16.0.r,
                    children: [
                      // drag handle
                      Center(
                        child: Container(
                          width: 40.0.r,
                          height: 4.0.r,
                          margin: const EdgeInsets.only(bottom: 16.0).r,
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(4.0.r),
                          ),
                        ),
                      ),

                      Column(
                        spacing: 20.0.r,
                        children: [
                          // Header
                          Row(
                            crossAxisAlignment: .center,
                            mainAxisAlignment: .spaceBetween,
                            mainAxisSize: .max,
                            children: [
                              Column(
                                crossAxisAlignment: .start,
                                mainAxisAlignment: .center,
                                mainAxisSize: .min,
                                children: [
                                  Text(
                                    'Purchase Request',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.0.sp,
                                    ),
                                  ),

                                  Text(
                                    'Created Date : Aug 17, 2025',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 11.0.sp,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: Colors.grey,
                                ),
                                onPressed: () => showHistoryDialog(context),
                              ),
                            ],
                          ),

                          // Transaction No
                          _infoRow(Icons.tag, 'Transaction No.', '000000001'),

                          _infoRow(
                            Icons.person_outline,
                            'Requested By',
                            'Servo Tech Support',
                          ),

                          _infoRow(
                            Icons.home_work_outlined,
                            'Property',
                            'Property A',
                          ),

                          _infoRow(
                            Icons.description_outlined,
                            'Notes',
                            '{SampleNotes}',
                          ),

                          Row(
                            children: [
                              Transform.rotate(
                                angle: 45 * 3 / 180,
                                // convert degrees to radians
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.attach_file_rounded,
                                    size: 22.0.r,
                                  ),
                                ),
                              ),

                              Row(
                                spacing: 12.0.r,
                                children: [
                                  Text(
                                    'quote.pdf',
                                    style: TextStyle(
                                      fontSize: 13.0.sp,
                                      color: Colors.indigo,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  Text(
                                    'invoice.jpg',
                                    style: TextStyle(
                                      fontSize: 13.0.sp,
                                      color: Colors.indigo,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          _infoRow(Icons.format_list_numbered, 'Quantity', '5'),

                          _infoRow(
                            Icons.info_outline,
                            'Total Amount',
                            '5,000.00',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Action Buttons
              Padding(
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
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => const RejectDialog(),
                              ).then((reason) {
                                if (reason != null) {
                                  debugPrint('User reason: $reason');
                                }
                              });
                            },
                            icon: const Icon(Icons.close, color: Colors.white),
                            label: const Text(
                              'Reject',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.check, color: Colors.white),
                            label: const Text(
                              'Approve',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.undo, color: Colors.black87),
                            label: const Text(
                              'Return for Revision',
                              style: TextStyle(color: Colors.black87),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1.0.r,
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
      child: Row(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        spacing: 8.0.r,
        children: [
          Icon(icon, color: Colors.black87, size: 22.0.r),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              mainAxisSize: .max,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.0.sp,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

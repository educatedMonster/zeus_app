import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/utils/extensions.dart';
import '../widgets/purchase_dialog_action_buttons.dart';
import '../widgets/purchase_dialog_header.dart';
import '../widgets/purchase_dialog_info_row.dart';
import 'reject_dialog.dart';
import 'show_history_dialog.dart';

class PurchaseRequestDialog extends StatelessWidget {
  const PurchaseRequestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();

    return DraggableScrollableSheet(
      initialChildSize: 0.80,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (bc, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
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
                            color: colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(4.0.r),
                          ),
                        ),
                      ),

                      Column(
                        spacing: 16.0.r,
                        children: [
                          // Header
                          PurchaseDialogHeader(
                            colorScheme: colorScheme,
                            title: 'Purchase Request',
                            date: 'Created Date : Aug 17, 2025',
                            onHistoryTap: () =>
                                showHistoryDialog(bc, colorScheme),
                          ),

                          // Transaction No
                          PurchaseDialogInfoRow(
                            colorScheme: colorScheme,
                            icon: Icons.tag,
                            label: 'Transaction No.',
                            value: '000000001',
                          ),

                          PurchaseDialogInfoRow(
                            colorScheme: colorScheme,
                            icon: Icons.person_outline,
                            label: 'Requested By',
                            value: 'Servo Tech Support',
                          ),

                          PurchaseDialogInfoRow(
                            colorScheme: colorScheme,
                            icon: Icons.home_work_outlined,
                            label: 'Property',
                            value: 'Property A',
                          ),

                          PurchaseDialogInfoRow(
                            colorScheme: colorScheme,
                            icon: Icons.description_outlined,
                            label: 'Notes',
                            value: '{SampleNotes}',
                          ),

                          Row(
                            children: [
                              Transform.rotate(
                                angle: 45 * 3 / 180,
                                // convert degrees to radians
                                child: IconButton(
                                  onPressed: () async {},
                                  icon: Icon(
                                    Icons.attach_file_rounded,
                                    size: 16.0.r,
                                    color: colorScheme.onTertiary,
                                  ),
                                ),
                              ),

                              Row(
                                spacing: 12.0.r,
                                children: [
                                  Text(
                                    'quote.pdf',
                                    style: buttonTextStyle(colorScheme.primary),
                                  ),

                                  Text(
                                    'invoice.jpg',
                                    style: buttonTextStyle(colorScheme.primary),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          PurchaseDialogInfoRow(
                            colorScheme: colorScheme,
                            icon: Icons.format_list_numbered,
                            label: 'Quantity',
                            value: '5',
                          ),

                          PurchaseDialogInfoRow(
                            colorScheme: colorScheme,
                            icon: Icons.info_outline,
                            label: 'Total Amount',
                            value: '5,000.00',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Action Buttons
              PurchaseDialogActionButtons(
                colorScheme: colorScheme,
                onApproveTap: () async {
                  bc.maybePop();
                },
                onRejectTap: () async {
                  showDialog(
                    context: bc,
                    builder: (_) => RejectDialog(colorScheme: colorScheme),
                  ).then((reason) {
                    if (reason != null) {
                      debugPrint('User reason: $reason');
                    }
                  });
                },
                onReturnTap: () async {
                  bc.maybePop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

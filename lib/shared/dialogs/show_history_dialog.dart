import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../core/constants/app_text_styles.dart';
import 'notes_dialog.dart';

void showHistoryDialog(BuildContext context, ColorScheme colorScheme) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (bc) {
      final historyData = [
        {
          'name': 'Juan Dela Cruz',
          'action': 'Returned',
          'date': 'Aug 25, 2025',
          'notes': 'Sample note 1',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Returned',
          'date': 'Aug 24, 2025',
          'notes': 'Sample note 2',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Rejected',
          'date': 'Aug 23, 2025',
          'notes': 'Sample note 3',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Returned',
          'date': 'Aug 25, 2025',
          'notes': 'Sample note 1',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Returned',
          'date': 'Aug 24, 2025',
          'notes': 'Sample note 2',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Rejected',
          'date': 'Aug 23, 2025',
          'notes': 'Sample note 3',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Returned',
          'date': 'Aug 25, 2025',
          'notes': 'Sample note 1',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Returned',
          'date': 'Aug 24, 2025',
          'notes': 'Sample note 2',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Rejected',
          'date': 'Aug 23, 2025',
          'notes': 'Sample note 3',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Returned',
          'date': 'Aug 25, 2025',
          'notes': 'Sample note 1',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Returned',
          'date': 'Aug 24, 2025',
          'notes': 'Sample note 2',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Rejected',
          'date': 'Aug 23, 2025',
          'notes': 'Sample note 3',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Returned',
          'date': 'Aug 25, 2025',
          'notes': 'Sample note 1',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Returned',
          'date': 'Aug 24, 2025',
          'notes': 'Sample note 2',
          'approved_by': 'Admin',
        },
        {
          'name': 'Juan Dela Cruz',
          'action': 'Rejected',
          'date': 'Aug 23, 2025',
          'notes': 'Sample note 3',
          'approved_by': 'Admin',
        },
      ];

      double screenHeight = bc.contextHeight();
      double screenWidth = bc.contextWidth();

      return Dialog(
        backgroundColor: colorScheme.surfaceContainer,
        elevation: 0.1,
        shadowColor: colorScheme.onSurface,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 32.0,
        ).r,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth,
            maxHeight: screenHeight * 0.50,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16.0.r,
              children: [
                // Header
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'History of Approval',
                    style: xlargeTitleTextStyle(colorScheme.onSurface),
                  ),
                ),

                // Table-like content
                Flexible(
                  child: LayoutBuilder(
                    builder: (ctx, constraints) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: .horizontal,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: DataTableTheme(
                              data: DataTableThemeData(
                                headingRowColor: WidgetStateProperty.all(
                                  colorScheme.surface,
                                ),
                                headingTextStyle: defaultTitleTextStyle(
                                  colorScheme,
                                ),
                                dataTextStyle: dataCellTextStyle(colorScheme),
                                columnSpacing: 8.0.r,
                              ),
                              child: DataTable(
                                headingRowHeight: kTextTabBarHeight,
                                showCheckboxColumn: false,
                                border: TableBorder.symmetric(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                columns: const [
                                  DataColumn(
                                    label: Text('Name'),
                                    headingRowAlignment:
                                        MainAxisAlignment.start,
                                  ),
                                  DataColumn(
                                    label: Text('Action'),
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                  ),
                                  DataColumn(
                                    label: Text('Date'),
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                  ),
                                  DataColumn(
                                    label: Text('Notes'),
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                  ),
                                  DataColumn(
                                    label: Text('Approved by'),
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                  ),
                                ],
                                rows: historyData.map((item) {
                                  final isRejected =
                                      item['action'] == 'Rejected';
                                  final isReturned =
                                      item['action'] == 'Returned';

                                  int index = historyData.indexWhere(
                                    (d) => d['name'] == item['name'],
                                  );
                                  final isEven = index.isEven;

                                  return DataRow(
                                    // alternate background color
                                    color:
                                        WidgetStateProperty.resolveWith<Color?>(
                                          (Set<WidgetState> states) {
                                            if (states.contains(
                                              WidgetState.selected,
                                            )) {
                                              return colorScheme.primary;
                                            }
                                            return isEven
                                                ? colorScheme.surfaceContainer
                                                : colorScheme.surfaceContainer
                                                      .withValues(alpha: 0.10);
                                          },
                                        ),
                                    cells: [
                                      DataCell(Text(item['name']!)),
                                      DataCell(
                                        Center(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 2.0,
                                            ).r,
                                            decoration: BoxDecoration(
                                              color: isRejected
                                                  ? Colors.red
                                                  : Colors.grey.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Text(
                                              item['action']!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(child: Text(item['date']!)),
                                      ),
                                      DataCell(
                                        Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.notes_outlined,
                                              size: 18.0.r,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: ctx,
                                                barrierDismissible: true,
                                                builder: (_) => NotesDialog(
                                                  note: item["notes"]
                                                      .toString(),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(item['approved_by']!),
                                        ),
                                      ),
                                    ],
                                    // Handles row tap
                                    onSelectChanged: (selected) {
                                      if (selected == true) {
                                        // You can navigate, show dialog, etc.
                                        showDialog(
                                          context: ctx,
                                          barrierDismissible: true,
                                          builder: (_) => NotesDialog(
                                            note: item["notes"].toString(),
                                          ),
                                        );
                                      }
                                    },
                                    onLongPress: () {
                                      debugPrint(
                                        'Long pressed row 1 with value: ${item['name']} ${item['action']} ${item['date']} ${item['notes']} ${item['approved_by']}',
                                      );
                                      // showHistoryDialog(context);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
                    onPressed: () => bc.maybePop(),
                    child: Text(
                      'Close',
                      style: buttonTextStyle(colorScheme.onSurface),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

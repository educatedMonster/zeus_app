import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/dialogs/pruchase_order_dialog.dart';

class ApprovalPurchaseOrderDataTableCard extends StatelessWidget {
  final ScrollController parentController;
  final ScrollController childController;

  const ApprovalPurchaseOrderDataTableCard({
    super.key,
    required this.parentController,
    required this.childController,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();

    final data = [
      {
        'trans_no': '{TransNo}',
        'property': '{Property}',
        'date': '{Date}',
        'requester': '{Name}',
        'total': '1,500.00',
      },
      {
        'trans_no': '{TransNo}',
        'property': '{Property}',
        'date': '{Date}',
        'requester': '{Name}',
        'total': '1,500.00',
      },
      {
        'trans_no': '{TransNo}',
        'property': '{Property}',
        'date': '{Date}',
        'requester': '{Name}',
        'total': '1,500.00',
      },
      {
        'trans_no': '{TransNo}',
        'property': '{Property}',
        'date': '{Date}',
        'requester': '{Name}',
        'total': '1,500.00',
      },
      {
        'trans_no': '{TransNo}',
        'property': '{Property}',
        'date': '{Date}',
        'requester': '{Name}',
        'total': '1,500.00',
      },
      {
        'trans_no': '{TransNo}',
        'property': '{Property}',
        'date': '{Date}',
        'requester': '{Name}',
        'total': '1,500.00',
      },
      {
        'trans_no': '{TransNo}',
        'property': '{Property}',
        'date': '{Date}',
        'requester': '{Name}',
        'total': '1,500.00',
      },
      {
        'trans_no': '{TransNo}',
        'property': '{Property}',
        'date': '{Date}',
        'requester': '{Name}',
        'total': '1,500.00',
      },
      {
        'trans_no': '{TransNo}',
        'property': '{Property}',
        'date': '{Date}',
        'requester': '{Name}',
        'total': '1,500.00',
      },
      {
        'trans_no': '{TransNo}',
        'property': '{Property}',
        'date': '{Date}',
        'requester': '{Name}',
        'total': '1,500.00',
      },
    ];

    void onTap(dynamic item) {
      debugPrint(
        'Long pressed row 1 with value: ${item['trans_no']} ${item['property']} ${item['date']} ${item['requester']} ${item['total']}',
      );
      // You can navigate, show dialog, etc.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const PurchaseOrderDialog(),
      );
    }

    // NOTE:
    // This manually forwards overscroll from child to parent.
    // Flutter does NOT support vertical scroll handoff natively.
    // Do not refactor unless you remove nested vertical scrolls.
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is OverscrollNotification &&
            parentController.hasClients) {
          parentController.jumpTo(
            (parentController.offset + notification.overscroll).clamp(
              parentController.position.minScrollExtent,
              parentController.position.maxScrollExtent,
            ),
          );
          return true; // consume overscroll
        }
        return false;
      },
      child: Container(
        width: width,
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ).copyWith(bottom: 8.0).r,
        padding: const EdgeInsets.symmetric(vertical: 24.0).r,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16.0.r),
          boxShadow: [
            BoxShadow(
              color: colorScheme.surfaceContainer.withValues(alpha: 0.1),
              blurRadius: 10.0.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final chartSize = constraints.maxWidth * 0.80;

            return Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: .spaceBetween,
              spacing: 4.0.r,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  spacing: 16.0.r,
                  children: [
                    /// Title and download icon
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
                      child: Row(
                        spacing: 8.0.r,
                        children: [
                          Transform.rotate(
                            angle: 45 * 3 / 180,
                            // convert degrees to radians
                            child: Icon(Icons.arrow_downward, size: 24.0.r),
                          ),

                          Text(
                            'Purchase Orders',
                            style: largeTitleTextStyle(colorScheme),
                            maxLines: 1,
                            overflow: .ellipsis,
                          ),
                        ],
                      ),
                    ),

                    /// Table
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0).r,
                      height: chartSize,
                      width: width,
                      child: SingleChildScrollView(
                        scrollDirection: .vertical,
                        controller: childController,
                        physics: const ClampingScrollPhysics(),
                        child: SingleChildScrollView(
                          scrollDirection: .horizontal,
                          child: DataTableTheme(
                            data: DataTableThemeData(
                              headingRowColor: WidgetStateProperty.all(
                                colorScheme.surface,
                              ),
                              headingTextStyle: defaultTitleTextStyle(
                                colorScheme,
                              ),
                              dataTextStyle: dataCellTextStyle(colorScheme),
                              // columnSpacing: 16.0.r,
                              // headingRowHeight: 40.0.r,
                              // dataRowMaxHeight: 48.0.r,
                              // horizontalMargin: 0.0.r,
                              // dataRowMinHeight: 36.0.r,
                              // dividerThickness: 0.0,
                            ),
                            child: DataTable(
                              showCheckboxColumn: false,
                              dividerThickness: 0.10.r,
                              border: TableBorder.symmetric(
                                borderRadius: BorderRadius.circular(16.0).r,
                              ),
                              columns: [
                                DataColumn(label: Text('Trans No.')),
                                DataColumn(label: Text('Property')),
                                DataColumn(label: Text('Date')),
                                DataColumn(label: Text('Requester')),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Total'),
                                  ),
                                ),
                              ],
                              rows: data.map((item) {
                                int index = data.indexWhere(
                                  (d) => d['name'] == item['name'],
                                );
                                final isEven = data.indexOf(item).isEven;

                                return DataRow(
                                  // alternate background color
                                  color:
                                      WidgetStateProperty.resolveWith<Color?>((
                                        Set<WidgetState> states,
                                      ) {
                                        if (states.contains(
                                          WidgetState.selected,
                                        )) {
                                          return colorScheme.primary;
                                        }
                                        return isEven
                                            ? colorScheme.surfaceContainer
                                            : colorScheme.surfaceContainer
                                                  .withValues(alpha: 0.10);
                                      }),
                                  cells: [
                                    DataCell(
                                      Row(
                                        mainAxisAlignment: .center,
                                        spacing: 4.0.r,
                                        children: [
                                          Opacity(
                                            opacity: data.indexOf(item).isEven
                                                ? 0.0
                                                : 1.0,
                                            // hides widget
                                            child: CircleAvatar(
                                              radius: 6.0.r,
                                              backgroundColor: Colors.red,
                                              child: Text(
                                                '!',
                                                style: TextStyle(
                                                  fontSize: 8.0.sp,
                                                  color: colorScheme.onPrimary,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(item['trans_no']!),
                                        ],
                                      ),
                                    ),
                                    DataCell(Text(item['property']!)),
                                    DataCell(Text(item['date']!)),
                                    DataCell(Text(item['requester']!)),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(item['total']!),
                                      ),
                                    ),
                                  ],
                                  // Handles row tap
                                  onSelectChanged: (selected) {
                                    if (selected == true) {
                                      onTap(item);
                                    }
                                  },
                                  onLongPress: () {
                                    onTap(item);
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                InkWell(
                  onTap: () async {},
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      spacing: 4.0.r,
                      mainAxisSize: .min,
                      children: [
                        Text(
                          'Load More',
                          style: buttonTextStyle(colorScheme.onSurface),
                        ),
                        moreButton(colorScheme.onSurface),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

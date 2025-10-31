import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/dialogs/pruchase_request_dialog.dart';

class ApprovalPurchaseRequestDataTableCard extends StatelessWidget {
  const ApprovalPurchaseRequestDataTableCard({super.key});

  @override
  Widget build(BuildContext context) {
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
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ).copyWith(bottom: 8.0).r,
      padding: EdgeInsets.symmetric(vertical: 24.0.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.0.r,
        children: [
          /// Table
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.0.r,
            children: [
              /// Title and download icon
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.r),
                child: Row(
                  spacing: 8.0.r,
                  children: [
                    Transform.rotate(
                      angle: 45 * 3 / 180,
                      // convert degrees to radians
                      child: Icon(Icons.arrow_downward, size: 24.0.r),
                    ),

                    Text(
                      'Purchase Requests',
                      style: TextStyle(
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTableTheme(
                  data: DataTableThemeData(
                    headingRowColor: WidgetStateProperty.all(
                      Colors.grey.shade100,
                    ),
                    headingTextStyle: TextStyle(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                    dataTextStyle: TextStyle(
                      fontSize: 13.0.sp,
                      color: Colors.black87,
                    ),
                    columnSpacing: 16.0.r,
                    // headingRowHeight: 40.0.r,
                    // dataRowMaxHeight: 48.0.r,
                    // horizontalMargin: 0.0.r,
                    // dataRowMinHeight: 36.0.r,
                    // dividerThickness: 0.0,
                  ),
                  child: DataTable(
                    showCheckboxColumn: false,
                    border: TableBorder.symmetric(
                      borderRadius: BorderRadius.circular(16.r),
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
                    rows: data.map((i) {
                      int index = data.indexWhere(
                        (d) => d['name'] == i['name'],
                      );
                      final item = data[index];
                      // final isEven = index.isEven;
                      final isEven = data.indexOf(i).isEven;

                      return DataRow(
                        // alternate background color
                        color: WidgetStateProperty.resolveWith<Color?>((
                          Set<WidgetState> states,
                        ) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.indigo.shade50;
                          }
                          return isEven ? Colors.white : Colors.grey.shade100;
                        }),
                        cells: [
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 4.0.r,
                              children: [
                                if (data.indexOf(i).isEven)
                                  CircleAvatar(
                                    radius: 8.0.r,
                                    backgroundColor: Colors.red,
                                    child: Text(
                                      '!',
                                      style: TextStyle(
                                        fontSize: 8.0.sp,
                                        color: Colors.white,
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
                            // You can navigate, show dialog, etc.
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) =>
                                  const PurchaseRequestDialog(),
                            );
                          }
                        },
                        onLongPress: () {
                          debugPrint(
                            'Long pressed row 1 with value: ${item['trans_no']} ${item['property']} ${item['date']} ${item['requester']} ${item['total']}',
                          );
                          // You can navigate, show dialog, etc.
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const PurchaseRequestDialog(),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Row(
              spacing: 4.0.r,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Load More',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Icon(Icons.chevron_right, size: 24.0.r, color: Colors.black87),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

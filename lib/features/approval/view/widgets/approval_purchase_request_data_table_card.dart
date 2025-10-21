import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/dialogs/pruchase_request_dialog.dart';

class ApprovalPurchaseRequestDataTableCard extends StatelessWidget {
  const ApprovalPurchaseRequestDataTableCard({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {
        'trans_no': 'Juan Dela Cruz',
        'banquet': '500K',
        'rooms': '500K',
        'others': '20K',
        'total': '1.12M',
      },
      {
        'trans_no': 'Carlos Mendoza',
        'banquet': '500K',
        'rooms': '500K',
        'others': '20K',
        'total': '1.12M',
      },
      {
        'trans_no': 'Sofia Reyes',
        'banquet': '500K',
        'rooms': '500K',
        'others': '20K',
        'total': '1.12M',
      },
      {
        'trans_no': 'Miguel Torres',
        'banquet': '500K',
        'rooms': '500K',
        'others': '20K',
        'total': '1.12M',
      },
      {
        'trans_no': 'Isabella Garcia',
        'banquet': '500K',
        'rooms': '500K',
        'others': '20K',
        'total': '1.12M',
      },
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ).copyWith(bottom: 8.0).r,
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 16.0.r),
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
        spacing: 16.0.r,
        children: [
          /// Title and download icon
          Row(
            children: [
              Transform.rotate(
                angle: 45 * 3 / 180, // convert degrees to radians
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_downward_outlined, size: 22),
                ),
              ),
              Expanded(
                child: Text(
                  'Purchase Requests',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          /// Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTableTheme(
              data: DataTableThemeData(
                headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
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
                columns: const [
                  DataColumn(label: Text('Trans No.')),
                  DataColumn(label: Text('Banquet')),
                  DataColumn(label: Text('Rooms')),
                  DataColumn(label: Text('Others')),
                  DataColumn(label: Text('Total')),
                ],
                rows: data.map((i) {
                  int index = data.indexWhere((d) => d['name'] == i['name']);
                  final item = data[index];
                  final isEven = index.isEven;

                  return DataRow(
                    // alternate background color
                    color: WidgetStateProperty.resolveWith<Color?>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.indigo.shade50;
                      }
                      return isEven ? Colors.white : Colors.grey.shade50;
                    }),
                    cells: [
                      DataCell(Text(item['trans_no']!)),
                      DataCell(Text(item['banquet']!)),
                      DataCell(Text(item['rooms']!)),
                      DataCell(Text(item['others']!)),
                      DataCell(Text(item['total']!)),
                    ],
                    // Handles row tap
                    onSelectChanged: (selected) {
                      if (selected == true) {
                        // You can navigate, show dialog, etc.
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const PurchaseRequestDialog(),
                        );
                      }
                    },
                    onLongPress: () {
                      debugPrint(
                        'Long pressed row 1 with value: ${item['trans_no']} ${item['banquet']} ${item['rooms']} ${item['others']} ${item['total']}',
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
    );
  }
}

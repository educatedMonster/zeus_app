import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewReportTimekeepingLateCard extends StatelessWidget {
  const ViewReportTimekeepingLateCard({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {"name": "Juan Dela Cruz", "days": 2, "mins": 137},
      {"name": "Liam O'Sullivan", "days": 2, "mins": 30},
      {"name": "Sophia Martinez", "days": 1, "mins": 24},
      {"name": "Ethan Black", "days": 1, "mins": 20},
      {"name": "Isabella Chen", "days": 1, "mins": 15},
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Dynamically size the chart based on card width
          final chartSize = constraints.maxWidth; // card width
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0.r,
            children: [
              /// Title and download icon
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _buildLegendDot(Colors.orange, 'Lates')),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.download_rounded, size: 22.sp),
                      ),
                    ],
                  ),
                  Text(
                    '15 were located late on this period.',
                    style: TextStyle(fontSize: 10.0.sp, color: Colors.black54),
                  ),
                ],
              ),

              /// Data Table
              Container(
                margin: EdgeInsets.symmetric(vertical: 4.0.r),
                width: chartSize,
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
                    border: TableBorder.symmetric(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    columns: const [
                      DataColumn(
                        headingRowAlignment: MainAxisAlignment.start,
                        label: Text('Name'),
                      ),
                      DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Row(
                          children: [
                            Text('Days'),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 16,
                              color: Colors.black45,
                            ),
                          ],
                        ),
                      ),
                      DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Row(
                          children: [
                            Text('Total Mins'),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 16,
                              color: Colors.black45,
                            ),
                          ],
                        ),
                      ),
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
                          DataCell(Text(item['name'].toString())),
                          DataCell(Center(child: Text(item['days'].toString()))),
                          DataCell(Center(child: Text(item['mins'].toString()))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      spacing: 8.0.r,
      children: [
        Container(
          width: 10.0.r,
          height: 10.0.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

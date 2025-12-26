import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/build_header_chart.dart';
import '../../../../viewmodel/view_report_view_model.dart';

class ViewReportTimekeepingAbsencesCard extends StatelessWidget {

  const ViewReportTimekeepingAbsencesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.contextColorScheme();
    final double width = context.contextWidth();
    final parentController = context
        .select<ViewReportViewModel, ScrollController>(
          (vm) => vm.parentController,
    );
    final childController = context
        .select<ViewReportViewModel, ScrollController>(
          (vm) => vm.childController,
    );
    final data = [
      {"name": "Juan Dela Cruz", "days": 2, "mins": 137},
      {"name": "Liam O'Sullivan", "days": 2, "mins": 30},
      {"name": "Sophia Martinez", "days": 1, "mins": 24},
      {"name": "Ethan Black", "days": 1, "mins": 20},
      {"name": "Isabella Chen", "days": 1, "mins": 15},
      {"name": "Juan Dela Cruz", "days": 2, "mins": 137},
      {"name": "Liam O'Sullivan", "days": 2, "mins": 30},
      {"name": "Sophia Martinez", "days": 1, "mins": 24},
      {"name": "Ethan Black", "days": 1, "mins": 20},
      {"name": "Isabella Chen", "days": 1, "mins": 15},
    ];

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
        margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
        padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 16.0.r),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: colorScheme.surfaceContainer.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final chartSize = constraints.maxWidth * 0.80;

            return Column(
              crossAxisAlignment: .start,
              spacing: 8.0.r,
              children: [
                /// Title and download icon
                BuildHeaderChart(
                  label: 'Absences',
                  color: Colors.red,
                  caption: '20 were located absent on this period',
                  icon: Icon(Icons.download_rounded, size: 22.sp),
                  onIconPressed: () {
                    debugPrint('Download icon pressed');
                  },
                ),

                /// Data Table
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0.r),
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
                            colorScheme.onSurface.withValues(alpha: 0.10),
                          ),
                          headingTextStyle: TextStyle(
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                          dataTextStyle: TextStyle(
                            fontSize: 13.0.sp,
                            color: colorScheme.onSurface,
                          ),
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
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          columns: [
                            DataColumn(
                              headingRowAlignment: MainAxisAlignment.start,
                              label: Text(
                                'Name',
                                style: TextStyle(color: colorScheme.onSurface),
                              ),
                            ),
                            DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Row(
                                children: [
                                  Text(
                                    'Days',
                                    style: TextStyle(
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 16,
                                    color: colorScheme.onSurface,
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
                                    color: colorScheme.onSurface,
                                  ),
                                ],
                              ),
                            ),
                          ],
                          rows: data.map((i) {
                            int index = data.indexWhere(
                              (d) => d['name'] == i['name'],
                            );
                            final item = data[index];
                            final isEven = index.isEven;

                            return DataRow(
                              // alternate background color
                              color: WidgetStateProperty.resolveWith<Color?>((
                                Set<WidgetState> states,
                              ) {
                                if (states.contains(WidgetState.selected)) {
                                  return colorScheme.primary;
                                }
                                return isEven
                                    ? colorScheme.surfaceContainer
                                    : colorScheme.onSurface.withValues(
                                        alpha: 0.10,
                                      );
                              }),
                              cells: [
                                DataCell(
                                  Text(
                                    item['name'].toString(),
                                    style: TextStyle(
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      item['days'].toString(),
                                      style: TextStyle(
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      item['mins'].toString(),
                                      style: TextStyle(
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
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

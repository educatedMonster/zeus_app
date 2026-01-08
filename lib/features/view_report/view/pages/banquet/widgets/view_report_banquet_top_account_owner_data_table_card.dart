import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/build_header_chart.dart';
import '../../../../viewmodel/view_report_view_model.dart';

class ViewReportBanquetTopAccountOwnerDataTableCard extends StatelessWidget {
  const ViewReportBanquetTopAccountOwnerDataTableCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.contextColorScheme();
    final double width = context.contextWidth();
    final (parentController, childController) = context
        .select<ViewReportViewModel, (ScrollController, ScrollController)>(
          (vm) => (vm.parentController, vm.childController),
        );

    final data = [
      {
        'name': 'Juan Dela Cruz',
        'banquet': '500K',
        'rooms': '500K',
        'others': '20K',
        'total': '1.12M',
      },
      {
        'name': 'Carlos Mendoza',
        'banquet': '500K',
        'rooms': '500K',
        'others': '20K',
        'total': '1.12M',
      },
      {
        'name': 'Sofia Reyes',
        'banquet': '500K',
        'rooms': '500K',
        'others': '20K',
        'total': '1.12M',
      },
      {
        'name': 'Miguel Torres',
        'banquet': '500K',
        'rooms': '500K',
        'others': '20K',
        'total': '1.12M',
      },
      {
        'name': 'Isabella Garcia',
        'banquet': '500K',
        'rooms': '500K',
        'others': '20K',
        'total': '1.12M',
      },
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0).r,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16.0).r,
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
              crossAxisAlignment: .start,
              spacing: 16.0.r,
              children: [
                /// Title and download icon
                BuildHeaderChart(
                  label: 'Top 5 Account Owner',
                  icon: iconDownload(),
                  onIconPressed: () async {
                    debugPrint('Download icon pressed');
                  },
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
                            colorScheme.onSurface.withValues(alpha: 0.020),
                          ),
                          headingTextStyle: defaultTitleTextStyle(colorScheme),
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
                          showBottomBorder: true,
                          dividerThickness: 0.0.r,
                          columns: [
                            DataColumn(
                              label: Text(
                                'Name',
                                style: defaultTitleTextStyle(colorScheme),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Banquet',
                                style: defaultTitleTextStyle(colorScheme),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Rooms',
                                style: defaultTitleTextStyle(colorScheme),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Others',
                                style: defaultTitleTextStyle(colorScheme),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Total',
                                style: defaultTitleTextStyle(colorScheme),
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
                                    : colorScheme.surfaceContainer.withValues(
                                        alpha: 0.10,
                                      );
                              }),
                              cells: [
                                DataCell(
                                  Text(
                                    item['name'].toString(),
                                    style: dataCellTextStyle(colorScheme),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    item['banquet'].toString(),
                                    style: dataCellTextStyle(colorScheme),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    item['rooms'].toString(),
                                    style: dataCellTextStyle(colorScheme),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    item['others'].toString(),
                                    style: dataCellTextStyle(colorScheme),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    item['total'].toString(),
                                    style: dataCellTextStyle(colorScheme),
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

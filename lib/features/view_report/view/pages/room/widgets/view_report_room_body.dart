import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/widgets/breadcrumbs_property.dart';
import '../../../../../../shared/widgets/date_picker.dart';
import 'view_report_room_occupancy_rate_card.dart';
import 'view_report_room_revenue_chart_card.dart';
import 'view_report_room_summary_grid_card.dart';

class ViewReportRoomBody extends StatelessWidget {
  final int counter;

  const ViewReportRoomBody({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8.0.r,
        children: [
          /// DATE
          DatePicker(),

          /// BREADCRUMBS
          BreadcrumbsProperty(property: '{Property #}', moduleName: 'Rooms'),

          /// REPORT OCCUPANCY RATE CARD
          ViewReportRoomOccupancyRateCard(),

          /// REPORT SUMMARY GRID CARD
          Column(
            children: List.generate(
              1,
              (i) => ViewReportRoomSummaryGridCard(
                parentKeyAnimation: '${DateTime.now()}-$i',
              ),
            ),
          ),

          /// REPORT REVENUE CHART CARD
          ViewReportRoomRevenueChartCard(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ],
      ),
    );
  }
}

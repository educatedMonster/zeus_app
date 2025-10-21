import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../dashboard/view/widgets/dashboard_date_picker.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0.r,
        children: [
          /// DATE
          DashboardDatePicker(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              spacing: 8.0.r,
              children: [
                Transform.rotate(
                  angle: 120 * 3 / 180, // convert degrees to radians
                  child: Icon(Icons.link_off, size: 16.0.r),
                ),
                Row(
                  children: [
                    Text(
                      'Property',
                      style: TextStyle(color: Colors.black87, fontSize: 14.0.sp),
                    ),
                    Text(
                      ' / ',
                      style: TextStyle(color: Colors.black87, fontSize: 14.0.sp),
                    ),
                    Text(
                      'Rooms',
                      style: TextStyle(color: Colors.black87, fontSize: 14.0.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// REPORT OCCUPANCY RATE CARD
          ViewReportRoomOccupancyRateCard(),

          /// REPORT SUMMARY GRID CARD
          Column(children: List.generate(1, (i) => ViewReportRoomSummaryGridCard(parentKeyAnimation: '${DateTime.now()}-$i'))),

          /// REPORT REVENUE CHART CARD
          ViewReportRoomRevenueChartCard(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ],
      ),
    );
  }
}

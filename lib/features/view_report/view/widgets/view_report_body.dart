import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../pages/banquet/widgets/view_report_banquet_business_source_card.dart';
import '../pages/banquet/widgets/view_report_banquet_collection_card.dart';
import '../pages/banquet/widgets/view_report_banquet_market_segment_card.dart';
import '../pages/banquet/widgets/view_report_banquet_top_account_owner_data_table_card.dart';
import '../pages/room/widgets/view_report_room_occupancy_rate_card.dart';
import '../pages/room/widgets/view_report_room_revenue_chart_card.dart';
import '../pages/room/widgets/view_report_room_summary_grid_card.dart';

class ViewReportBody extends StatelessWidget {
  final int counter;

  const ViewReportBody({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0.r,
        children: [
          /// REPORT OCCUPANCY RATE CARD
          ViewReportRoomOccupancyRateCard(),

          /// REPORT SUMMARY GRID CARD
          Column(children: List.generate(1, (i) => ViewReportRoomSummaryGridCard(parentKeyAnimation: '$i'))),

          /// REPORT REVENUE CHART CARD
          ViewReportRoomRevenueChartCard(),

          /// REPORT MARKET SEGMENT CARD
          ViewReportMarketSegmentCard(),

          /// REPORT BUSINESS SOURCE CARD
          ViewReportBanquetBusinessSourceCard(),

          /// REPORT COLLECTION CARD
          ViewReportBanquetCollectionCard(),

          /// TOP ACCOUNT OWNER DATA TABLE CARD
          ViewReportBanquetTopAccountOwnerDataTableCard(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ],
      ),
    );
  }
}

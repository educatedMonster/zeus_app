import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/date_picker.dart';
import 'dashboard_occupancy_rate_card.dart';
import 'dashboard_revenue_breakdown_card.dart';
import 'dashboard_revenue_by_property_chart.dart';
import 'dashboard_revenue_card.dart';
import 'dashboard_revenue_centers_tab_card.dart';

class DashboardBody extends StatelessWidget {
  final int counter;

  const DashboardBody({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0.r,
          children: [
            /// DATE
            DatePicker(),

            /// REVENUE SUMMARY CARD
            DashboardRevenueCard(),

            /// REVENUE BY PROPERTY CHART
            DashboardRevenueByPropertyChart(),

            /// OCCUPANCY RATE CARD
            Column(
              children: List.generate(
                1,
                (i) => DashboardOccupancyRateCard(parentKeyAnimation: '0', childKeyAnimation: '$i'),
              ),
            ),

            /// REVENUE BREAKDOWN CARD
            DashboardRevenueBreakdownCard(),

            /// REVENUE CENTERS TAB CARD
            DashboardRevenueCentersTabCard(),

            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          ],
        ),
      ),
    );
  }
}

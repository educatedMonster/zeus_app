import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/features/dashboard/view/widgets/dashboard_revenue_breakdown_card.dart';
import 'package:zeus_app/features/view_report/data/sources/remote/model/revenue_data_model.dart';

import '../../../../shared/widgets/date_picker.dart';
import '../../data/sources/remote/model/pie_chart_section_model.dart';
import 'dashboard_occupancy_rate_card.dart';
import 'dashboard_revenue_by_property_chart.dart';
import 'dashboard_revenue_card.dart';
import 'dashboard_revenue_centers_tab_card.dart';

class DashboardBody extends StatelessWidget {
  final int counter;

  const DashboardBody({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    /// DUMMY
    final List<PieChartSectionModel> pieChartSections1 = [
      PieChartSectionModel(
        title: 'Rooms',
        badge: '65%',
        value: 65,
        color: Color(0xFF3B4BFF),
      ),
      PieChartSectionModel(
        title: 'Banquet',
        badge: '20%',
        value: 20,
        color: Color(0xFFFFA53B),
      ),
      PieChartSectionModel(
        title: 'Coffee Shop',
        badge: '15%',
        value: 15,
        color: Color(0xFF2DB7A3),
      ),
    ];

    final List<PieChartSectionModel> pieChartSections2 = [
      PieChartSectionModel(
        title: 'Rooms',
        badge: '65%',
        value: 65,
        color: Color(0xFF3B4BFF),
      ),
      PieChartSectionModel(
        title: 'Banquet',
        badge: '20%',
        value: 20,
        color: Color(0xFFFFA53B),
      ),
      PieChartSectionModel(
        title: 'Coffee Shop',
        badge: '15%',
        value: 15,
        color: Color(0xFF2DB7A3),
      ),
    ];

    List<RevenueDataModel> list1 = [
      RevenueDataModel(label: '14', order: 0, a: 200000, b: 100000, c: 150000),
      RevenueDataModel(label: '15', order: 1, a: 180000, b: 120000, c: 200000),
      RevenueDataModel(label: '16', order: 2, a: 300000, b: 250000, c: 220000),
      RevenueDataModel(label: '17', order: 3, a: 180000, b: 80000, c: 190000),
    ];

    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0.r,
          children: [
            Column(
              children: List.generate(
                1,
                (i) => DashboardRevenueBreakdownCard(
                  parentKeyAnimation: '0',
                  childKeyAnimation: '$i',
                  pieChartSectionModelList: pieChartSections1,
                ),
              ),
            ),

            /// DATE
            DatePicker(),

            /// REVENUE SUMMARY CARD
            DashboardRevenueCard(),

            /// REVENUE BY PROPERTY CHART
            Column(
              children: List.generate(
                1,
                (i) => DashboardRevenueByPropertyChart(
                  parentKeyAnimation: '0',
                  childKeyAnimation: '$i',
                  revenueBarDataModelList: list1,
                ),
              ),
            ),

            /// OCCUPANCY RATE CARD
            Column(
              children: List.generate(
                1,
                (i) => DashboardOccupancyRateCard(
                  parentKeyAnimation: '0',
                  childKeyAnimation: '$i',
                ),
              ),
            ),

            /// REVENUE BREAKDOWN CARD
            Column(
              children: List.generate(
                1,
                (i) => DashboardRevenueBreakdownCard(
                  parentKeyAnimation: '1',
                  childKeyAnimation: '$i',
                  pieChartSectionModelList: pieChartSections2,
                ),
              ),
            ),

            /// REVENUE CENTERS TAB CARD
            DashboardRevenueCentersTabCard(),

            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          ],
        ),
      ),
    );
  }
}

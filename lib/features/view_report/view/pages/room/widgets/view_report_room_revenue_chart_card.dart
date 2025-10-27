import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/widgets/animated_revenue_line_chart.dart';
import '../../../../../../shared/widgets/build_header_chart.dart';

class ViewReportRoomRevenueChartCard extends StatelessWidget {
  const ViewReportRoomRevenueChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> revenueSpots = const [
      FlSpot(0, 1.7e6), // Apr
      FlSpot(1, 0.6e6), // May
      FlSpot(2, 1.5e6), // Jun
      FlSpot(3, 0.5e6), // Jul
      FlSpot(4, 1.2e6), // Aug
    ];

    final List<LineChartBarData> revenueLineBarsData = [
      LineChartBarData(
        isCurved: true,
        // dashArray: [1, 2, 4],
        curveSmoothness: 0.50,
        preventCurveOverShooting: true,
        color: Colors.indigo,
        barWidth: 2,
        gradientArea: LineChartGradientArea.rectAroundTheLine,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: revenueSpots,
      ), // Aug
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
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
          final containerHeight = constraints.maxHeight;
          final containerWidth = constraints.maxWidth;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.0.r,
            children: [
              /// Title and download icon
              BuildHeaderChart(
                label: 'Revenue Chart',
                icon: Icon(Icons.download_rounded, size: 22.sp),
                onIconPressed: () {
                  debugPrint('Download icon pressed');
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRevenueInfo(title: 'This Week', value: '430.5k'),
                  _buildRevenueInfo(title: 'This Month', value: '1.2M'),
                  _buildRevenueInfo(title: 'This Year', value: '32.5M'),
                ],
              ),

              AnimatedRevenueLineChart(
                keyAnimation: 'view-report-room-revenue-chard-card-1',
                progressColor: Colors.blue,
                containerHeight: containerHeight * 0.50,
                containerWidth: containerWidth,
                lineBarsData: revenueLineBarsData,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRevenueInfo({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        Text(title, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewReportMarketSegmentCard extends StatelessWidget {
  const ViewReportMarketSegmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      PieChartSectionData(
        color: Colors.red,
        // Rooms
        value: 23,
        title: '23%',
        radius: 55.r,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.blue,
        // Banquet
        value: 10,
        title: '10%',
        radius: 55.r,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.orange,
        // Coffee Shop
        value: 27,
        title: '27%',
        radius: 55.r,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.green,
        // Rooms
        value: 5,
        title: '5%',
        radius: 55.r,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.indigo,
        // Banquet
        value: 10,
        title: '10%',
        radius: 55.r,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.brown,
        // Coffee Shop
        value: 25,
        title: '25%',
        radius: 55.r,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
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
          final chartSize = constraints.maxWidth * 0.40; // 45% of card width

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.0.r,
            children: [
              /// Title and download icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Production by Market Segment',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.download_rounded, size: 22.sp),
                  ),
                ],
              ),

              /// Chart and Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Legend Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.0.r,
                    children: [
                      _buildLegendDot(Colors.red, 'Promotion'),
                      _buildLegendDot(Colors.blue, 'Direct'),
                      _buildLegendDot(Colors.orange, 'Corporate'),
                      _buildLegendDot(Colors.green, 'Government'),
                      _buildLegendDot(Colors.indigo, 'Travel Agents'),
                      _buildLegendDot(Colors.brown, 'Others'),
                    ],
                  ),

                  /// Pie Chart (dynamic size)
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.0.r,
                      vertical: 24.0.r,
                    ),
                    height: chartSize,
                    width: chartSize,
                    child: PieChart(
                      PieChartData(
                        sections: sections,
                        centerSpaceRadius: chartSize * 0.25,
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 1.0.r,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8.0.r,
      children: [
        Container(
          width: 10.0.r,
          height: 10.0.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 13.sp, color: Colors.black87),
        ),
      ],
    );
  }
}

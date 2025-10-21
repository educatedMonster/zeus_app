import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ViewReportRoomOccupancyRateCard extends StatelessWidget {
  const ViewReportRoomOccupancyRateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
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
          final circleRadius = containerHeight * 0.25;
          final lineWidth = containerHeight * 0.05;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16.0.r,
            children: [
              /// Title and download icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Occupancy Rate',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              Expanded(
                child: CircularPercentIndicator(
                  radius: circleRadius,
                  lineWidth: lineWidth,
                  percent: .80,
                  animation: true,
                  animationDuration: 1200, // Duration in milliseconds
                  startAngle: 180,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: const Color(0xFFE9ECF2),
                  progressColor: const Color(0xFF3B4BFF),
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.grey[600],
                        size: containerHeight * 0.08,
                      ),
                      Text(
                        '80%',
                        style: TextStyle(
                          fontSize: containerHeight * 0.1,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16.0.r,
                children: [
                  _buildLegendDot(
                    color: const Color(0xFF3B4BFF),
                    label: 'Actual 20/26',
                  ),
                  _buildLegendDot(
                    color: const Color(0xFFD5D9E2),
                    label: 'Projected 24/26',
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLegendDot({required Color color, required String label}) {
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
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

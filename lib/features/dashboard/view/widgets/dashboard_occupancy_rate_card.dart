import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/animated_line_progress_bar.dart';
import '../../../view_report/data/sources/remote/model/progress_ chart_model.dart';

class DashboardOccupancyRateCard extends StatelessWidget {
  final String parentKeyAnimation;

  const DashboardOccupancyRateCard({
    super.key,
    required this.parentKeyAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final list = [
      ProgressChartModel(
        isProgress: true,
        title: 'Property A',
        value: 0.5,
        current: "0.5",
        total: "0.5",
        progressColor: Colors.indigo,
        progressBGColor: Colors.indigo.withValues(alpha: 0.1),
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
      ProgressChartModel(
        isProgress: true,
        title: 'Property B',
        value: 0.3,
        current: "0.8",
        total: "0.8",
        progressColor: Colors.orange,
        progressBGColor: Colors.orange.withValues(alpha: 0.15),
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
      ProgressChartModel(
        isProgress: true,
        title: 'Property C',
        value: 0.2,
        current: '0.2',
        total: "0.2",
        progressColor: Colors.teal,
        progressBGColor: Colors.teal.withValues(alpha: 0.15),
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 24.0.r),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0.r,
        children: [
          /// Title
          Text(
            'Occupancy Rate',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          Column(
            children: List.generate(list.length, (index) {
              final item = list[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0.r),

                  _buildProgressCard(
                    keyAnimation: '$parentKeyAnimation-dashboard_occupancy_rate_card-$index',
                    title: item.title,
                    progressColor: item.progressColor,
                    backgroundColor: item.progressBGColor,
                    value: item.value,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard({
    required String keyAnimation,
    required String title,
    required Color progressColor,
    required Color backgroundColor,
    required double value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.0.r,
      children: [
        /// Label row (name + percent)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        /// Progress bar
        AnimatedLineProgressBar(
          value: value,
          backgroundColor: backgroundColor,
          progressColor: progressColor,
          keyAnimation: keyAnimation,
        ),
      ],
    );
  }
}

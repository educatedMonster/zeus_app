import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/widgets/animated_line_progress_bar.dart';
import '../../../../data/sources/remote/model/progress_ chart_model.dart';

class ViewReportRoomSummaryGridCard extends StatelessWidget {
  final String parentKeyAnimation;

  const ViewReportRoomSummaryGridCard({super.key, required this.parentKeyAnimation});

  @override
  Widget build(BuildContext context) {
    final list = [
      ProgressChartModel(
        isProgress: true,
        title: 'Arrivals',
        value: 0.3,
        current: "3",
        total: "10",
        progressColor: Colors.indigo,
        progressBGColor: Colors.indigo.withValues(alpha: 0.1),
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
      ProgressChartModel(
        isProgress: true,
        title: 'Departures',
        value: 0.5,
        current: "5",
        total: "10",
        progressColor: Colors.indigo,
        progressBGColor: Colors.indigo.withValues(alpha: 0.1),
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
      ProgressChartModel(
        isProgress: false,
        title: 'Stay-Over',
        value: 59,
        current: '59',
        total: "59",
        progressColor: Colors.black87,
        progressBGColor: Colors.white,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
      ProgressChartModel(
        isProgress: false,
        title: 'Total Revenue',
        value: 435000,
        current: '43.5k',
        total: "43.5k",
        progressColor: Colors.white,
        progressBGColor: Colors.indigo,
        backgroundColor: Colors.indigo ,
        textColor: Colors.white,
      ),
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 8.0.r),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 8.0.r,
        mainAxisSpacing: 8.0.r,
        childAspectRatio: 1.7,
        children: List.generate(list.length, (index) {
          final item = list[index];
          return item.isProgress
              ? _buildProgressCard(
                  keyAnimation: '$parentKeyAnimation-view_report_room_summary_grid_card-$index',
                  title: item.title,
                  progressColor: item.progressColor,
                  backgroundColor: item.progressBGColor,
                  value: item.value,
                  current: item.current,
                  total: item.total,
                )
              : _buildValueCard(
                  title: item.title,
                  value: item.total,
                  bgColor: item.backgroundColor,
                  textColor: item.textColor,
                );
        }),
      ),
    );
  }

  /// Progress Card (Arrivals, Departures)
  Widget _buildProgressCard({
    required String keyAnimation,
    required String title,
    required Color progressColor,
    required Color backgroundColor,
    required double value,
    required String current,
    required String total,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0).r,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0.r,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12.sp, color: Colors.black87),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(value * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Text(
                '$current/$total',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
            ],
          ),

          /// Progress bar
          AnimatedLineProgressBar(value: value, backgroundColor: backgroundColor, progressColor: progressColor, keyAnimation: keyAnimation),
        ],
      ),
    );
  }

  /// Value Card (Stay-Over, Total Revenue)
  Widget _buildValueCard({
    required String title,
    required String value,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0).r,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8.0.r,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: textColor.withValues(alpha: 0.8),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

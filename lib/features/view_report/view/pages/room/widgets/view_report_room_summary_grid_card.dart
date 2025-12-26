import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/animated_line_progress_bar.dart';
import '../../../../data/sources/remote/model/progress_ chart_model.dart';

class ViewReportRoomSummaryGridCard extends StatelessWidget {
  final String parentKeyAnimation;

  const ViewReportRoomSummaryGridCard({
    super.key,
    required this.parentKeyAnimation,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();

    final list = [
      ProgressChartModel(
        isProgress: true,
        title: 'Arrivals',
        value: 0.3,
        current: "3",
        total: "10",
        progressColor: colorScheme.primary,
        progressBGColor: Colors.indigo.withValues(alpha: 0.20),
        backgroundColor: colorScheme.surfaceContainer,
        textColor: colorScheme.onSurface,
      ),
      ProgressChartModel(
        isProgress: true,
        title: 'Departures',
        value: 0.5,
        current: "5",
        total: "10",
        progressColor: colorScheme.primary,
        progressBGColor: Colors.indigo.withValues(alpha: 0.20),
        backgroundColor: colorScheme.surfaceContainer,
        textColor: colorScheme.onSurface,
      ),
      ProgressChartModel(
        isProgress: false,
        title: 'Stay-Over',
        value: 59,
        current: '59',
        total: "59",
        progressColor: colorScheme.surfaceContainer,
        progressBGColor: colorScheme.onSurface,
        backgroundColor: colorScheme.surfaceContainer,
        textColor: colorScheme.onSurface,
      ),
      ProgressChartModel(
        isProgress: false,
        title: 'Total Revenue',
        value: 435000,
        current: '43.5k',
        total: "43.5k",
        progressColor: colorScheme.onPrimary,
        progressBGColor: Colors.indigo,
        backgroundColor: colorScheme.primary,
        textColor: colorScheme.onPrimary,
      ),
    ];

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 8.0.r),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.surfaceContainer.withValues(alpha: 0.1),
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
                  keyAnimation:
                      '$parentKeyAnimation-view_report_room_summary_grid_card-$index',
                  title: item.title,
                  progressColor: item.progressColor,
                  progressBGColor: item.progressBGColor,
                  value: item.value,
                  current: item.current,
                  total: item.total,
                  bgColor: item.backgroundColor,
                  textColor: item.textColor,
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
    required Color progressBGColor,
    required double value,
    required String current,
    required String total,
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
        crossAxisAlignment: .start,
        spacing: 8.0.r,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12.sp, color: textColor),
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                '${(value * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              Text(
                '$current/$total',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: textColor.withValues(alpha: 0.50),
                ),
              ),
            ],
          ),

          /// Progress bar
          AnimatedLineProgressBar(
            value: value,
            backgroundColor: progressBGColor,
            progressColor: progressColor,
            keyAnimation: keyAnimation,
          ),
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
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
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

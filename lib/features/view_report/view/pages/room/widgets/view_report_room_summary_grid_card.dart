import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/line_progress_card.dart';
import '../../../../../../shared/widgets/value_card.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(16.0).r,
        boxShadow: [
          BoxShadow(
            color: colorScheme.surfaceContainer.withValues(alpha: 0.1),
            blurRadius: 10.0.r,
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
              ? LineProgressCard(
                  colorScheme: colorScheme,
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
              : ValueCard(
                  title: item.title,
                  value: item.total,
                  bgColor: item.backgroundColor,
                  textColor: item.textColor,
                );
        }),
      ),
    );
  }
}

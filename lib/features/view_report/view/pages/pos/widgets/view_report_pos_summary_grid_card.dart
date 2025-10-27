import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/shared/widgets/build_legend_dot.dart';

import '../../../../data/sources/remote/model/progress_ chart_model.dart';

class ViewReportPosSummaryGridCard extends StatelessWidget {
  final List<ProgressChartModel> list;

  const ViewReportPosSummaryGridCard({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      decoration: BoxDecoration(
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
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 8.0.r,
        mainAxisSpacing: 8.0.r,
        childAspectRatio: 1.75,
        children: List.generate(list.length, (index) {
          final item = list[index];
          return Container(
            padding: const EdgeInsets.all(12.0).r,
            decoration: BoxDecoration(
              color: item.backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 8.0.r,
              children: [
                Expanded(child: BuildLegendDot(color: item.progressColor, label: item.title)),
                Expanded(
                  child: Text(
                    item.current,
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.normal,
                      color: item.textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

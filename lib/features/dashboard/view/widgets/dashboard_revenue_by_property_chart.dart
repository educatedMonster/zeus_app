import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/animated_revenue_bar_chart.dart';
import '../../../../shared/widgets/build_header_chart.dart';
import '../../../../shared/widgets/build_legend_dot.dart';
import '../../../view_report/data/sources/remote/model/revenue_data_model.dart';

class DashboardRevenueByPropertyChart extends StatelessWidget {
  final String parentKeyAnimation;
  final String childKeyAnimation;
  final List<RevenueDataModel> revenueBarDataModelList;

  const DashboardRevenueByPropertyChart({
    super.key,
    required this.parentKeyAnimation,
    required this.childKeyAnimation,
    required this.revenueBarDataModelList,
  });

  @override
  Widget build(BuildContext context) {
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
          final chartSize = constraints.maxWidth * 0.60; // 60% of card width

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24.0.r,
            children: [
              /// Title and download icon
              BuildHeaderChart(
                label: 'Revenue by Property',
                icon: Icon(Icons.download_rounded, size: 22.sp),
                onIconPressed: () {
                  debugPrint('Download icon pressed');
                },
              ),

              /// Chart
              revenueBarDataModelList.isEmpty
                  ? SizedBox(
                      height: chartSize,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8.0.r,
                        children: [
                          Icon(Icons.bar_chart, color: Colors.grey, size: 48),
                          const Text(
                            'No data available',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24.0.r,
                      children: [
                        /// Legend
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 16.0.r,
                            children: [
                              BuildLegendDot(
                                color: Colors.blue,
                                label: 'Property A',
                              ),
                              BuildLegendDot(
                                color: Colors.orange,
                                label: 'Property B',
                              ),
                              BuildLegendDot(
                                color: Colors.teal,
                                label: 'Property C',
                              ),
                              // Add more if needed
                            ],
                          ),
                        ),

                        /// Chart
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: chartSize,
                            child: AnimatedRevenueBarChart(
                              keyAnimation:
                                  '$parentKeyAnimation-$childKeyAnimation-dashboard_revenue_by_property_chart',
                              list: revenueBarDataModelList,
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
}

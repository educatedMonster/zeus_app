import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/build_legend_dot.dart';
import '../../../../shared/widgets/pie_chart_badge.dart';
import '../../data/sources/remote/model/pie_chart_section_model.dart';

class DashboardRevenueBreakdownCard extends StatefulWidget {
  const DashboardRevenueBreakdownCard({super.key});

  @override
  State<DashboardRevenueBreakdownCard> createState() =>
      _DashboardRevenueBreakdownCardState();
}

class _DashboardRevenueBreakdownCardState
    extends State<DashboardRevenueBreakdownCard> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<PieChartSectionModel> sections = [
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

    List<PieChartSectionData> showingSections() {
      return List.generate(sections.length, (i) {
        final section = sections[i];
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 10.0.sp : 8.0.sp;
        final radius = isTouched ? 60.0.r : 55.0.r;
        final widgetSize = isTouched ? 35.0.r : 30.0.r;

        return PieChartSectionData(
          color: section.color,
          value: section.value,
          title: section.title,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: section.color,
          ),
          badgeWidget: PieBadge(
            value: '${section.value}',
            size: widgetSize,
            borderColor: Colors.black87,
          ),
          badgePositionPercentageOffset: 0.90,
        );
      });
    }

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
          final chartSize = constraints.maxWidth * 0.45; // 45% of card width

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.0.r,
            children: [
              /// Title
              Text(
                'Revenue Breakdown',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              /// Chart and Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Legend Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(sections.length, (index) {
                      final section = sections[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.0.r),
                        child: InkWell(
                          onTapDown: (_) => setState(() => touchedIndex = index),
                          onTapUp: (_) => setState(() => touchedIndex = -1),
                          child: BuildLegendDot(
                            color: section.color,
                            label: section.title,
                          ),
                        ),
                      );
                    }),
                  ),

                  /// Pie Chart (dynamic size)
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.0.r,
                      vertical: 24.0.r,
                    ),
                    width: chartSize,
                    height: chartSize, // Ensure it's square
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!
                                      .touchedSectionIndex;
                                });
                              },
                        ),
                        sections: showingSections(),
                        // sections: sections,
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
}

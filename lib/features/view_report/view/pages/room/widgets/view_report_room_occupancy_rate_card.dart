import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../../core/constants/app_fonts.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/build_header_chart.dart';
import '../../../../../../shared/widgets/build_legend_dot.dart';

class ViewReportRoomOccupancyRateCard extends StatelessWidget {
  const ViewReportRoomOccupancyRateCard({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double height = context.contextHeight();
    double width = context.contextWidth();

    return Container(
      height: height * 0.35,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0).r,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.0).r,
        boxShadow: [
          BoxShadow(
            color: colorScheme.surfaceContainer.withValues(alpha: 0.1),
            blurRadius: 10.0.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final containerHeight = constraints.maxHeight;
          final circleRadius = containerHeight * 0.30;
          final lineWidth = containerHeight * 0.05;

          return Column(
            crossAxisAlignment: .center,
            mainAxisAlignment: .center,
            spacing: 16.0.r,
            children: [
              /// Title and download icon
              BuildHeaderChart(label: 'Occupancy Rate'),

              Expanded(
                child: CircularPercentIndicator(
                  radius: circleRadius,
                  lineWidth: lineWidth,
                  percent: .80,
                  animation: true,
                  animationDuration: 1200,
                  // Duration in milliseconds
                  startAngle: 180,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.indigo.shade50,
                  progressColor: colorScheme.primary,
                  center: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0).r,
                        child: CircleAvatar(
                          radius: 16.0.r,
                          backgroundColor: colorScheme.surface.withValues(alpha: 1.0),
                          child: Icon(
                            Icons.person_outline,
                            color: colorScheme.primary,
                            size: containerHeight * 0.090,
                          ),
                        ),
                      ),

                      Text(
                        '80%',
                        style: TextStyle(
                          fontSize: containerHeight * 0.10,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                          fontFamily: Fonts.fontMontserrat,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: .center,
                spacing: 16.0.r,
                children: [
                  BuildLegendDot(
                    color: colorScheme.primary,
                    label: 'Actual 20/26',
                  ),
                  BuildLegendDot(
                    color: colorScheme.tertiary,
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
}

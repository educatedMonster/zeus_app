import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/widgets/animated_line_progress_bar.dart';

class ViewReportTimekeepingCard extends StatelessWidget {
  final String parentKeyAnimation;

  const ViewReportTimekeepingCard({super.key, required this.parentKeyAnimation});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0.r,
        children: [
          /// Title
          Text(
            'Present',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          /// Property B
          _buildProgressRow(
            keyAnimation: '$parentKeyAnimation-view_report_timekeeping_body-1',
            title: '80%',
            progressColor: Colors.orange,
            backgroundColor: Colors.orange.withValues(alpha: 0.15),
            value: 0.8,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRow({
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
              '${(value * 100).toInt()}/100',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        /// Progress bar
        AnimatedLineProgressBar(value: value, backgroundColor: backgroundColor, progressColor: progressColor, keyAnimation: keyAnimation),

        // Stack(
        //   alignment: Alignment.centerLeft,
        //   children: [
        //     Container(
        //       height: 8.0.r,
        //       width: double.infinity,
        //       decoration: BoxDecoration(
        //         color: backgroundColor,
        //         borderRadius: BorderRadius.circular(10.r),
        //       ),
        //     ),
        //     TweenAnimationBuilder<double>(
        //       tween: Tween<double>(begin: 0, end: value),
        //       duration: Duration(seconds: 1), // smooth 1 second animation
        //       curve: Curves.easeInOut,
        //       builder: (context, animatedValue, child) {
        //         return FractionallySizedBox(
        //           widthFactor: animatedValue,
        //           child: Container(
        //             height: 8.r,
        //             decoration: BoxDecoration(
        //               color: progressColor,
        //               borderRadius: BorderRadius.circular(10.r),
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //     Positioned(
        //       right: 0,
        //       child: Container(
        //         width: 8.0.r,
        //         height: 5.0.r,
        //         decoration: BoxDecoration(color: progressColor, shape: BoxShape.circle),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

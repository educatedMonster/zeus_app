import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_text_styles.dart';

class ByShiftView extends StatelessWidget {
  final ColorScheme colorScheme;

  const ByShiftView({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0).r,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 16.0.r,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text('Day Shift', style: defaultTitleTextStyle(colorScheme)),
              Text('154,000.00', style: mediumTitleTextStyle(colorScheme)),
            ],
          ),

          Column(
            crossAxisAlignment: .start,
            children: [
              Text('Night Shift', style: defaultTitleTextStyle(colorScheme)),
              Text('80,000.00', style: mediumTitleTextStyle(colorScheme)),
            ],
          ),
        ],
      ),
    );
  }
}

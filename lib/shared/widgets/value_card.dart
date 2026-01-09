import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_fonts.dart';
import '../../core/constants/app_text_styles.dart';

class ValueCard extends StatelessWidget {
  final String title;
  final String value;
  final Color textColor;
  final Color bgColor;

  const ValueCard({
    super.key,
    required this.title,
    required this.value,
    required this.textColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
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
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              color: textColor.withValues(alpha: 0.8),
              fontFamily: Fonts.fontPoppins,
            ),
          ),
          Text(value, style: xlargeTitleTextStyle(textColor)),
        ],
      ),
    );
  }
}

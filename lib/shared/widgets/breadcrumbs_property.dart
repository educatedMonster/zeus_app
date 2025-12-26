import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/extensions.dart';

class BreadcrumbsProperty extends StatelessWidget {
  final String property;
  final String moduleName;

  const BreadcrumbsProperty({
    super.key,
    required this.property,
    required this.moduleName,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
      child: SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Wrap(
          spacing: 8.0.r,
          children: [
            Transform.rotate(
              angle: 120 * 3 / 180, // convert degrees to radians
              child: Icon(Icons.link_off, size: 16.0.r),
            ),
            Row(
              children: [
                Text(
                  property,
                  style: TextStyle(color: colorScheme.onSurface, fontSize: 14.0.sp),
                ),
                Text(
                  ' / ',
                  style: TextStyle(color: colorScheme.onSurface, fontSize: 14.0.sp),
                ),
                Text(
                  moduleName,
                  style: TextStyle(color: colorScheme.onSurface, fontSize: 14.0.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

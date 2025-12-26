import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/extensions.dart';

class ReportAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leadingWidget;

  const ReportAppBar({
    super.key,
    required this.title,
    required this.leadingWidget,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();

    return AppBar(
      backgroundColor: colorScheme.surfaceContainer,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      centerTitle: true,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18.0.sp,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, size: 16.0.r),
                color: colorScheme.onSurface,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.notifications_none, size: 16.0.r),
                color: colorScheme.onSurface,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      leading: leadingWidget,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0).r,
          child: CircleAvatar(
            radius: 16.0.r,
            backgroundColor: const Color(0xFFB0B8C1),
            child: Text(
              'A',
              style: TextStyle(color: colorScheme.onPrimary, fontSize: 14.sp),
            ),
          ),
        ),
      ],
    );
  }
}

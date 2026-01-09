import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_text_styles.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ColorScheme colorScheme;
  final String title;
  final Widget leadingWidget;

  const DashboardAppBar({
    super.key,
    required this.colorScheme,
    required this.title,
    required this.leadingWidget,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorScheme.surfaceContainer,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: colorScheme.onSurface,
      titleSpacing: 0,
      centerTitle: true,
      title: Row(
        crossAxisAlignment: .center,
        mainAxisAlignment: .spaceEvenly,
        children: [
          Text(title, style: appBarTextStyle(colorScheme)),
          const Spacer(),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, size: 16.0.r),
                color: colorScheme.onSurface,
                onPressed: () async {},
              ),
              IconButton(
                icon: Icon(Icons.notifications_none, size: 16.0.r),
                color: colorScheme.onSurface,
                onPressed: () async {},
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
            child: Text('A', style: buttonTextStyle(colorScheme.onPrimary)),
          ),
        ),
      ],
    );
  }
}

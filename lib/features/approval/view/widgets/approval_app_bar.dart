import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/extensions.dart';

class ApprovalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leadingWidget;
  final TabController tabController;
  final List<String> tabs;

  const ApprovalAppBar({
    super.key,
    required this.title,
    required this.leadingWidget,
    required this.tabController,
    required this.tabs,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(kTextTabBarHeight + kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();

    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: colorScheme.onSurface,
      titleSpacing: 0,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0).r,
        child: Row(
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
              spacing: 12.0.r,
              children: [
                Icon(Icons.search, size: 20.0.r, color: colorScheme.onSurface),
                Icon(
                  Icons.notifications_none,
                  size: 20.0.r,
                  color: colorScheme.onSurface,
                ),
              ],
            ),
          ],
        ),
      ),
      leading: leadingWidget,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0).r,
          child: CircleAvatar(
            radius: 12.0.r,
            backgroundColor: const Color(0xFFB0B8C1),
            child: Text(
              'A',
              style: TextStyle(
                color: colorScheme.surfaceContainer,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.50),
        indicatorSize: TabBarIndicatorSize.label,
        // fill each tab
        indicatorPadding: EdgeInsets.zero,
        indicatorColor: colorScheme.primary,
        // no extra padding
        // indicatorWeight: 1,
        // prevent thin default line
        dividerColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        tabs: tabs
            .map(
              (tab) => Tab(
                child: Badge(
                  isLabelVisible: true,
                  offset: Offset(16, -8),
                  label: Text('1'),
                  child: Text(
                    tab,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

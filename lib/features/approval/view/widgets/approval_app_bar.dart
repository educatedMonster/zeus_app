import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_text_styles.dart';

class ApprovalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ColorScheme colorScheme;
  final String title;
  final Widget leadingWidget;
  final TabController tabController;
  final List<String> tabs;

  const ApprovalAppBar({
    super.key,
    required this.colorScheme,
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
      bottom: TabBar(
        controller: tabController,
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.50),
        indicatorSize: TabBarIndicatorSize.tab,
        // fill each tab
        indicatorPadding: EdgeInsets.zero,
        indicatorColor: colorScheme.primary,
        // no extra padding
        indicatorWeight: 2.0.r,
        // prevent thin default line
        dividerColor: colorScheme.onSurface.withValues(alpha: 0.10),
        dividerHeight: 1.0.r,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        tabs: tabs
            .map(
              (tab) => Tab(
                child: Badge(
                  isLabelVisible: true,
                  // alignment: AlignmentDirectional.centerEnd,
                  offset: Offset(18, -8),
                  label: Text(
                    '1',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                  child: Text(
                    tab,
                    style: tabBarTextStyle(colorScheme),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    // textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

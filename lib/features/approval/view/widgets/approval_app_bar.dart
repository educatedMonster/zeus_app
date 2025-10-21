import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return AppBar(
      toolbarHeight: kTextTabBarHeight + kTextTabBarHeight,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0).r,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Approvals',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18.0.sp,
              ),
            ),
            const Spacer(),
            Row(
              spacing: 12.0.r,
              children: [
                Icon(Icons.search, size: 20.0.r),
                Icon(Icons.notifications_none, size: 20.0.r),
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
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        dividerColor: Colors.transparent,
        indicatorColor: Colors.indigo,
        indicatorWeight: 1,
        tabAlignment: TabAlignment.fill,
        indicatorSize: TabBarIndicatorSize.label,
        padding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        unselectedLabelColor: Colors.grey,
        tabs: tabs
            .map(
              (tab) => Tab(
                height: kTextTabBarHeight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tab),

                    if (tab == 'Pending')
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 8.0,
                            right: 2.0,
                            left: 2.0,
                          ).r,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ).r,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.0.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

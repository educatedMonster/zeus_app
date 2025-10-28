import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SampleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SampleAppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
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
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18.0.sp,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, size: 16.0.r),
                color: Colors.black87,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.notifications_none, size: 16.0.r),
                color: Colors.black87,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, size: 16.0.r),
        color: Colors.black87,
        onPressed: () {
          var currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild?.unfocus();
          } else {
            context.router.maybePop();
          }
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0).r,
          child: CircleAvatar(
            radius: 16.0.r,
            backgroundColor: const Color(0xFFB0B8C1),
            child: Text(
              'A',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ),
      ],
    );
  }
}

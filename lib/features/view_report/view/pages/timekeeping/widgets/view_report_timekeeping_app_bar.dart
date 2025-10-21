import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewReportTimekeepingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const ViewReportTimekeepingAppBar({super.key, required this.title});

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
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0).r,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 18.0.sp,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, size: 20.0.r),
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
        IconButton(
          icon: Icon(Icons.close, size: 20.0.r),
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
      ],
    );
  }
}

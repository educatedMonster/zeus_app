import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/extensions.dart';

class ViewReportPosAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const ViewReportPosAppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();

    return AppBar(
      backgroundColor: colorScheme.surfaceContainer,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: colorScheme.onSurface,
      titleSpacing: 0,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0).r,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 18.0.sp,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, size: 20.0.r),
        color: colorScheme.onSurface,
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
          color: colorScheme.onSurface,
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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/app_text_styles.dart';

class ViewReportRoomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final ColorScheme colorScheme;
  final String title;

  const ViewReportRoomAppBar({
    super.key,
    required this.colorScheme,
    required this.title,
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
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0).r,
      centerTitle: false,
      title: Text(title, style: appBarTextStyle(colorScheme)),
      leading: IconButton(
        icon: backButton(),
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
          icon: closeButton(),
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

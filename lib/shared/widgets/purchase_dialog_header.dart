import 'package:flutter/material.dart';

import '../../core/constants/app_text_styles.dart';

class PurchaseDialogHeader extends StatelessWidget {
  final ColorScheme colorScheme;
  final String title;
  final String date;
  final VoidCallback onHistoryTap;

  const PurchaseDialogHeader({
    super.key,
    required this.colorScheme,
    required this.title,
    required this.date,
    required this.onHistoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .center,
      mainAxisAlignment: .spaceBetween,
      mainAxisSize: .max,
      children: [
        Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            Text(title, style: xlargeTitleTextStyle(colorScheme.onSurface)),
            Text(date, style: defaultCaptionTextStyle(colorScheme)),
          ],
        ),
        IconButton(icon: editButton(colorScheme), onPressed: onHistoryTap),
      ],
    );
  }
}

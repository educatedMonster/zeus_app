import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions.dart';

class ViewReportBanquetFab extends StatelessWidget {
  final VoidCallback onPressed;

  const ViewReportBanquetFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();

    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: Icon(Icons.add, color: colorScheme.onPrimary),
    );
  }
}

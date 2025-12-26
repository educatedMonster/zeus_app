import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions.dart';

class ViewReportAccountingFab extends StatelessWidget {
  final VoidCallback onPressed;

  const ViewReportAccountingFab({super.key, required this.onPressed});

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

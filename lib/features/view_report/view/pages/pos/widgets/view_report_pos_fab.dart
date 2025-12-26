import 'package:flutter/material.dart';
import 'package:zeus_app/core/utils/extensions.dart';

class ViewReportPosFab extends StatelessWidget {
  final VoidCallback onPressed;

  const ViewReportPosFab({super.key, required this.onPressed});

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

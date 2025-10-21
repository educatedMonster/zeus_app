import 'package:flutter/material.dart';

class ViewReportTimekeepingFab extends StatelessWidget {
  final VoidCallback onPressed;

  const ViewReportTimekeepingFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

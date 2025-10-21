import 'package:flutter/material.dart';

class ViewReportPosFab extends StatelessWidget {
  final VoidCallback onPressed;

  const ViewReportPosFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

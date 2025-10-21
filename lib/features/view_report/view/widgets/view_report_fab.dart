import 'package:flutter/material.dart';

class ViewReportFab extends StatelessWidget {
  final VoidCallback onPressed;

  const ViewReportFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

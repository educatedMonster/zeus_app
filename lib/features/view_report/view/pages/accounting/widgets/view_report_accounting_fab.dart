import 'package:flutter/material.dart';

class ViewReportAccountingFab extends StatelessWidget {
  final VoidCallback onPressed;

  const ViewReportAccountingFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

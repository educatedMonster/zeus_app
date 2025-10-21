import 'package:flutter/material.dart';

class ViewReportBanquetFab extends StatelessWidget {
  final VoidCallback onPressed;

  const ViewReportBanquetFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

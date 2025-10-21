import 'package:flutter/material.dart';

class ReportFab extends StatelessWidget {
  final VoidCallback onPressed;

  const ReportFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

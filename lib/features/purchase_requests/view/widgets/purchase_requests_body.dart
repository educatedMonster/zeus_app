import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseRequestsBody extends StatelessWidget {
  final int counter;

  const PurchaseRequestsBody({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0.r,
        children: [SizedBox(height: MediaQuery.of(context).size.height * 0.25)],
      ),
    );
  }
}

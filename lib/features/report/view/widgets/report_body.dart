import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'report_property_card.dart';

class ReportBody extends StatelessWidget {
  final int counter;

  const ReportBody({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8.0.r,
        children: [
          /// REPORT PROPERTY CARD
          ReportPropertyCard(title: 'Property A'),
          ReportPropertyCard(title: 'Property B'),
          ReportPropertyCard(title: 'Property C'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'report_property_card.dart';

class ReportBody extends StatelessWidget {
  final double height;
  final int counter;

  const ReportBody({super.key, required this.height, required this.counter});

  @override
  Widget build(BuildContext context) {
    final properties = ['Property A', 'Property B', 'Property C'];

    return ListView.builder(
      itemCount: properties.length + 1, // +1 for the SizedBox at the end
      itemBuilder: (context, index) {
        if (index < properties.length) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0).r,
            child: ReportPropertyCard(property: properties[index]),
          );
        }

        // Last item (spacing at the bottom)
        return SizedBox(height: height * 0.25.r);
      },
    );
  }
}

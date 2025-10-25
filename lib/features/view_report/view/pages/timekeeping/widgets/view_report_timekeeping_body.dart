import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/widgets/breadcrumbs_property.dart';
import '../../../../../../shared/widgets/date_picker.dart';
import 'view_report_timekeeping_2_card.dart';
import 'view_report_timekeeping_absences_card.dart';
import 'view_report_timekeeping_card.dart';
import 'view_report_timekeeping_early_bird_card.dart';
import 'view_report_timekeeping_late_card.dart';

class ViewReportTimekeepingBody extends StatelessWidget {
  final int counter;

  const ViewReportTimekeepingBody({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0.r,
        children: [
          /// DATE
          DatePicker(),

          /// BREADCRUMBS
          BreadcrumbsProperty(property: '{Property #}', moduleName: 'Timekeeping'),

          /// PRESENT CARD
          Column(children: List.generate(1, (i) => ViewReportTimekeepingCard(parentKeyAnimation: '$i'))),

          /// LATE AND ABSENCES
          Row(
            children: [
              Expanded(
                child: ViewReportTimekeeping2Card(
                  statusColor: Colors.orange,
                  label: 'Late',
                ),
              ),
              Expanded(
                child: ViewReportTimekeeping2Card(
                  statusColor: Colors.red,
                  label: 'Absences',
                ),
              ),
            ],
          ),

          /// EARLY BIRD DATA TABLE
          ViewReportTimekeepingEarlyBirdCard(),

          /// LATE DATA TABLE
          ViewReportTimekeepingLateCard(),

          /// ABSENCES DATA TABLE
          ViewReportTimekeepingAbsencesCard(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ],
      ),
    );
  }
}

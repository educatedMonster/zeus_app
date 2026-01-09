import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../shared/widgets/breadcrumbs_property.dart';
import '../../../../../../shared/widgets/date_picker.dart';
import '../../../../../../shared/widgets/status_card.dart';
import '../../../../viewmodel/view_report_view_model.dart';
import 'view_report_timekeeping_absences_card.dart';
import 'view_report_timekeeping_card.dart';
import 'view_report_timekeeping_early_bird_card.dart';
import 'view_report_timekeeping_late_card.dart';

class ViewReportTimekeepingBody extends StatelessWidget {
  final double height;
  final String property;
  final String module;
  final int counter;

  const ViewReportTimekeepingBody({
    super.key,
    required this.height,
    required this.property,
    required this.module,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    final (parentController) = context
        .select<ViewReportViewModel, ScrollController>(
          (vm) => vm.parentController,
        );

    return SingleChildScrollView(
      controller: parentController,
      physics: const ClampingScrollPhysics(),
      scrollDirection: .vertical,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8.0.r,
        children: [
          /// DATE
          DatePicker(),

          /// BREADCRUMBS
          BreadcrumbsProperty(property: property, moduleName: module),

          /// PRESENT CARD
          Column(
            children: List.generate(
              1,
              (i) => ViewReportTimekeepingCard(parentKeyAnimation: '$i'),
            ),
          ),

          /// LATE AND ABSENCES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
            child: Row(
              spacing: 8.0.r,
              children: [
                Expanded(
                  child: StatusCard(
                    statusColor: Colors.orange,
                    label: 'Late',
                    value: '15',
                  ),
                ),
                Expanded(
                  child: StatusCard(
                    statusColor: Colors.red,
                    label: 'Absences',
                    value: '20',
                  ),
                ),
              ],
            ),
          ),

          /// EARLY BIRD DATA TABLE
          ViewReportTimekeepingEarlyBirdCard(),

          /// LATE DATA TABLE
          ViewReportTimekeepingLateCard(),

          /// ABSENCES DATA TABLE
          ViewReportTimekeepingAbsencesCard(),

          SizedBox(height: height * 0.25.r),
        ],
      ),
    );
  }
}

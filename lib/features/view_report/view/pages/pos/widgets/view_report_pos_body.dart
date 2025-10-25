import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/widgets/breadcrumbs_property.dart';
import '../../../../../../shared/widgets/date_picker.dart';
import 'view_report_pos_best_seller_card.dart';
import 'view_report_pos_sales_card.dart';
import 'view_report_pos_summary_grid_card.dart';

class ViewReportPosBody extends StatelessWidget {
  final int counter;

  const ViewReportPosBody({super.key, required this.counter});

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
          BreadcrumbsProperty(property: '{Property #}', moduleName: 'POS'),

          /// REPORT SALES CARD
          ViewReportPosSalesCard(),

          /// REPORT SUMMARY GRID CARD
          ViewReportPosSummaryGridCard(),

          /// REPORT SALES CARD
          ViewReportPosSalesCard(),

          /// REPORT SUMMARY GRID CARD
          ViewReportPosSummaryGridCard(),

          /// REPORT SALES CARD
          ViewReportPosBestSellerCard(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ],
      ),
    );
  }
}

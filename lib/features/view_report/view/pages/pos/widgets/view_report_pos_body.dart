import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/widgets/auto_route_breadcrumbs.dart';
import '../../../../../../shared/widgets/breadcrumbs_property.dart';
import '../../../../../../shared/widgets/date_picker.dart';
import '../../../../data/sources/remote/model/progress_ chart_model.dart';
import 'view_report_pos_best_seller_card.dart';
import 'view_report_pos_sales_card.dart';
import 'view_report_pos_summary_grid_card.dart';

class ViewReportPosBody extends StatelessWidget {
  final int counter;

  const ViewReportPosBody({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    List<ProgressChartModel> list1 = [
      ProgressChartModel(
        isProgress: false,
        title: 'Gross Sales',
        value: 0.0,
        current: "72,523.00",
        total: "72,523.00",
        progressColor: Colors.indigo,
        progressBGColor: Colors.white,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
      ProgressChartModel(
        isProgress: false,
        title: 'Discounts',
        value: 0.0,
        current: "3,525.00",
        total: "3,525.00",
        progressColor: Colors.indigo,
        progressBGColor: Colors.white,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
      ProgressChartModel(
        isProgress: false,
        title: 'Service Charge',
        value: 0.0,
        current: "6,532.50",
        total: "6,532.50",
        progressColor: Colors.indigo,
        progressBGColor: Colors.white,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
      ProgressChartModel(
        isProgress: false,
        title: 'Total Revenue',
        value: 0.0,
        current: "0.00",
        total: "0.00",
        progressColor: Colors.indigo,
        progressBGColor: Colors.white,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
    ];
    List<ProgressChartModel> list2 = [
      ProgressChartModel(
        isProgress: false,
        title: 'Cash',
        value: 0.0,
        current: "2,549.80",
        total: "2,549.80",
        progressColor: Colors.orange,
        progressBGColor: Colors.white,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
      ProgressChartModel(
        isProgress: false,
        title: 'Credit Cards',
        value: 0.0,
        current: "15,236.10",
        total: "15,236.10",
        progressColor: Colors.orange,
        progressBGColor: Colors.white,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
      ProgressChartModel(
        isProgress: false,
        title: 'Others',
        value: 0.0,
        current: "2,156.00",
        total: "2,156.00",
        progressColor: Colors.orange,
        progressBGColor: Colors.white,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
      ProgressChartModel(
        isProgress: false,
        title: 'AR/CL',
        value: 0.0,
        current: "0.00",
        total: "0.00",
        progressColor: Colors.orange,
        progressBGColor: Colors.white,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
      ),
    ];

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
          ViewReportPosSalesCard(type: 'Sales', isPositive: true),

          /// REPORT SUMMARY GRID CARD
          ViewReportPosSummaryGridCard(list: list1),

          /// REPORT SALES CARD
          ViewReportPosSalesCard(type: 'Collections', isPositive: false),

          /// REPORT SUMMARY GRID CARD
          ViewReportPosSummaryGridCard(list: list2),

          /// REPORT SALES CARD
          ViewReportPosBestSellerCard(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ],
      ),
    );
  }
}

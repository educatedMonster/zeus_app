import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../dashboard/view/widgets/dashboard_date_picker.dart';
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
          DashboardDatePicker(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              spacing: 8.0.r,
              children: [
                Transform.rotate(
                  angle: 120 * 3 / 180, // convert degrees to radians
                  child: Icon(Icons.link_off, size: 16.0.r),
                ),
                Row(
                  children: [
                    Text(
                      'Property',
                      style: TextStyle(color: Colors.black87, fontSize: 14.0.sp),
                    ),
                    Text(
                      ' / ',
                      style: TextStyle(color: Colors.black87, fontSize: 14.0.sp),
                    ),
                    Text(
                      'POS',
                      style: TextStyle(color: Colors.black87, fontSize: 14.0.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),

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

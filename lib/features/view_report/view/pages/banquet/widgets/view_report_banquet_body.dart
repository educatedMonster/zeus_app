import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../dashboard/view/widgets/dashboard_date_picker.dart';
import 'view_report_banquet_business_source_card.dart';
import 'view_report_banquet_collection_card.dart';
import 'view_report_banquet_market_segment_card.dart';
import 'view_report_banquet_top_account_owner_data_table_card.dart';

class ViewReportBanquetBody extends StatelessWidget {
  final int counter;

  const ViewReportBanquetBody({super.key, required this.counter});

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
                      'Banquet',
                      style: TextStyle(color: Colors.black87, fontSize: 14.0.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// REPORT MARKET SEGMENT CARD
          ViewReportMarketSegmentCard(),

          /// REPORT BUSINESS SOURCE CARD
          ViewReportBanquetBusinessSourceCard(),

          /// REPORT COLLECTION CARD
          ViewReportBanquetCollectionCard(),

          /// TOP ACCOUNT OWNER DATA TABLE CARD
          ViewReportBanquetTopAccountOwnerDataTableCard(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ],
      ),
    );
  }
}

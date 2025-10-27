import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/widgets/breadcrumbs_property.dart';
import '../../../../../../shared/widgets/date_picker.dart';
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
          /// REPORT COLLECTION CARD
          ViewReportBanquetCollectionCard(),

          /// DATE
          DatePicker(),

          /// BREADCRUMBS
          BreadcrumbsProperty(property: '{Property #}', moduleName: 'Banquet'),

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

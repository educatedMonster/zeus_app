import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../../../../../shared/widgets/breadcrumbs_property.dart';
import '../../../../../../shared/widgets/date_picker.dart';
import '../../../../../dashboard/data/sources/remote/model/pie_chart_section_model.dart';
import '../../../../data/sources/remote/model/collection_data_model.dart';
import '../../../../viewmodel/view_report_view_model.dart';
import 'view_report_banquet_business_source_card.dart';
import 'view_report_banquet_collection_card.dart';
import 'view_report_banquet_market_segment_card.dart';
import 'view_report_banquet_top_account_owner_data_table_card.dart';

class ViewReportBanquetBody extends StatelessWidget {
  final int counter;

  const ViewReportBanquetBody({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    final double height = context.contextHeight();
    final parentController = context
        .select<ViewReportViewModel, ScrollController>(
          (vm) => vm.parentController,
        );

    /// DUMMY
    final List<PieChartSectionModel> pieChartSections1 = [
      PieChartSectionModel(
        title: 'Promotion',
        badge: '23%',
        value: 23,
        color: Colors.red,
      ),
      PieChartSectionModel(
        title: 'Direct',
        badge: '10%',
        value: 10,
        color: Colors.blue,
      ),
      PieChartSectionModel(
        title: 'Corporate',
        badge: '27%',
        value: 27,
        color: Colors.orange,
      ),
      PieChartSectionModel(
        title: 'Government',
        badge: '5%',
        value: 55,
        color: Colors.green,
      ),
      PieChartSectionModel(
        title: 'Travel Agents',
        badge: '10%',
        value: 10,
        color: Colors.indigo,
      ),
      PieChartSectionModel(
        title: 'Others',
        badge: '25%',
        value: 25,
        color: Colors.brown,
      ),
    ];

    /// DUMMY
    List<CollectionBarDataModel> collectionList = [
      CollectionBarDataModel(
        title: 'Cash',
        legendColor: Colors.red,
        label: '14',
        order: 0,
        a: 200000,
        b: 100000,
        c: 150000,
      ),
      CollectionBarDataModel(
        title: 'Card',
        legendColor: Colors.orange,
        label: '15',
        order: 1,
        a: 180000,
        b: 120000,
        c: 200000,
      ),
      CollectionBarDataModel(
        title: 'Others',
        legendColor: Colors.teal,
        label: '16',
        order: 2,
        a: 300000,
        b: 250000,
        c: 220000,
      ),
      CollectionBarDataModel(
        title: 'Total',
        legendColor: Colors.indigo,
        label: '17',
        order: 3,
        a: 180000,
        b: 80000,
        c: 190000,
      ),
    ];

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
          BreadcrumbsProperty(property: '{Property #}', moduleName: 'Banquet'),

          /// REPORT MARKET SEGMENT CARD
          Column(
            children: List.generate(
              1,
              (i) => ViewReportMarketSegmentCard(
                parentKeyAnimation: '0',
                childKeyAnimation: '$i',
                pieChartSectionModelList: pieChartSections1,
              ),
            ),
          ),

          /// REPORT BUSINESS SOURCE CARD
          Column(
            children: List.generate(
              1,
              (i) => ViewReportBanquetBusinessSourceCard(
                parentKeyAnimation: '1',
                childKeyAnimation: '$i',
                pieChartSectionModelList: pieChartSections1,
              ),
            ),
          ),

          /// REPORT COLLECTION CARD
          Column(
            children: List.generate(
              1,
              (i) => ViewReportBanquetCollectionCard(
                parentKeyAnimation: '0',
                childKeyAnimation: '$i',
                collectionBarDataModelList: collectionList,
              ),
            ),
          ),

          /// TOP ACCOUNT OWNER DATA TABLE CARD
          ViewReportBanquetTopAccountOwnerDataTableCard(),

          SizedBox(height: height * 0.25),
        ],
      ),
    );
  }
}

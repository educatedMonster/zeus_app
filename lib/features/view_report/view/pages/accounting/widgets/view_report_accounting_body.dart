import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/widgets/animated_bar_chart.dart';
import '../../../../../../shared/widgets/breadcrumbs_property.dart';
import '../../../../../../shared/widgets/date_picker.dart';
import '../../../../data/sources/remote/model/finance_bar_data_model.dart';
import 'view_report_accounting_card.dart';
import 'view_report_accounting_cash_in_out_chart.dart';
import 'view_report_accounting_expense_type_card.dart';
import 'view_report_accounting_finance_chart_card.dart';
import 'view_report_accounting_income_expense_chart.dart';
import 'view_report_accounting_sales_card.dart';

class ViewReportAccountingBody extends StatelessWidget {
  final int counter;

  const ViewReportAccountingBody({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    /// DUMMY
    List<FinanceBarDataModel> list1 = [
      FinanceBarDataModel(label: '1', order: 0, a: 5, b: 2),
      FinanceBarDataModel(label: '2', order: 1, a: 16, b: 12),
      FinanceBarDataModel(label: '3', order: 2, a: 18, b: 5),
      FinanceBarDataModel(label: '4', order: 4, a: 17, b: 6),
      FinanceBarDataModel(label: '5', order: 5, a: 19, b: 1.5),
      FinanceBarDataModel(label: '6', order: 6, a: 10, b: 1.5),
      FinanceBarDataModel(label: '7', order: 7, a: 30, b: 1.5),
    ];

    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0.r,
          children: [
            /// DATE
            DatePicker(),

            /// BREADCRUMBS
            BreadcrumbsProperty(property: '{Property #}', moduleName: 'Accounting'),

            /// REPORT SALES CARD
            ViewReportAccountingSalesCard(),

            ViewReportAccountingSalesCard(),

            ViewReportAccountingSalesCard(isNegativeStatus: true),

            ViewReportAccountingSalesCard(),

            Row(
              children: [
                Expanded(child: ViewReportAccountingCard()),
                Expanded(child: ViewReportAccountingCard()),
              ],
            ),

            ViewReportAccountingFinanceChartCard(),

            ViewReportAccountingExpenseTypeCard(),

            /// INCOME AND EXPENSE CHART
            Column(
              children: List.generate(
                1,
                    (i) => ViewReportAccountingIncomeExpenseChart(parentKeyAnimation: '1', childKeyAnimation: '$i', financeBarDataModelList: list1),
              ),
            ),

            /// CASH IN AND CASH OUT CHART
            Column(
              children: List.generate(
                1,
                    (i) => ViewReportAccountingCashInOutChart(parentKeyAnimation: '1', childKeyAnimation: '$i'),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          ],
        ),
      ),
    );
  }
}

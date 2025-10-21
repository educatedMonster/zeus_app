import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/widgets/animated_bar_chart.dart';
import '../../../../../dashboard/view/widgets/dashboard_date_picker.dart';
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
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
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
                        'Accounting',
                        style: TextStyle(color: Colors.black87, fontSize: 14.0.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// TEST
            ViewReportAccountingIncomeExpenseChart(),

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

            ViewReportAccountingIncomeExpenseChart(),

            ViewReportAccountingCashInOutChart(),

            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          ],
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zeus_app/core/constants/app_strings.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../../viewmodel/view_report_view_model.dart';
import 'widgets/view_report_banquet_app_bar.dart';
import 'widgets/view_report_banquet_body.dart';
import 'widgets/view_report_banquet_fab.dart';

@RoutePage()
class ViewReportBanquetPage extends StatefulWidget {
  const ViewReportBanquetPage({super.key});

  @override
  State<ViewReportBanquetPage> createState() => _ViewReportBanquetPageState();
}

class _ViewReportBanquetPageState extends State<ViewReportBanquetPage> {
  late ViewReportViewModel _viewReportViewModel;

  int _counter = 0;

  void _incrementCounter() {
    _viewReportViewModel.incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    _viewReportViewModel = context.watchViewReportVM();

    _counter = _viewReportViewModel.counter;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: ViewReportBanquetAppBar(title: Constants.titleViewReport),
      body: ViewReportBanquetBody(counter: _counter),
      floatingActionButton: ViewReportBanquetFab(onPressed: _incrementCounter),
    );
  }
}

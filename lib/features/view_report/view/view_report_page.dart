import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zeus_app/core/constants/app_strings.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../viewmodel/view_report_view_model.dart';
import 'widgets/view_report_app_bar.dart';
import 'widgets/view_report_body.dart';
import 'widgets/view_report_fab.dart';

@RoutePage()
class ViewReportPage extends StatefulWidget {
  const ViewReportPage({super.key});

  @override
  State<ViewReportPage> createState() => _ViewReportPageState();
}

class _ViewReportPageState extends State<ViewReportPage> {
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
      appBar: ViewReportAppBar(title: Constants.titleViewReport),
      body: ViewReportBody(counter: _counter),
      floatingActionButton: ViewReportFab(onPressed: _incrementCounter),
    );
  }
}

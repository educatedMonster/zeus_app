import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeus_app/core/constants/app_strings.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../../../../shared/viewmodels/date_picker_view_model.dart';
import '../../../viewmodel/view_report_view_model.dart';
import 'widgets/view_report_accounting_app_bar.dart';
import 'widgets/view_report_accounting_body.dart';
import 'widgets/view_report_accounting_fab.dart';

@RoutePage()
class ViewReportAccountingPage extends StatefulWidget {
  const ViewReportAccountingPage({super.key});

  @override
  State<ViewReportAccountingPage> createState() =>
      _ViewReportAccountingPageState();
}

class _ViewReportAccountingPageState extends State<ViewReportAccountingPage> {
  late ViewReportViewModel _viewReportViewModel;

  int _counter = 0;

  void _incrementCounter() {
    _viewReportViewModel.incrementCounter();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DatePickerViewModel>().resetDate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _viewReportViewModel = context.watchViewReportVM();

    _counter = _viewReportViewModel.counter;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: ViewReportAccountingAppBar(title: Constants.titleViewReport),
      body: ViewReportAccountingBody(counter: _counter),
      floatingActionButton: ViewReportAccountingFab(
        onPressed: _incrementCounter,
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeus_app/core/constants/app_strings.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../../../../shared/viewmodels/date_picker_view_model.dart';
import '../../../viewmodel/view_report_view_model.dart';
import 'widgets/view_report_timekeeping_app_bar.dart';
import 'widgets/view_report_timekeeping_body.dart';
import 'widgets/view_report_timekeeping_fab.dart';

@RoutePage()
class ViewReportTimekeepingPage extends StatefulWidget {
  const ViewReportTimekeepingPage({super.key});

  @override
  State<ViewReportTimekeepingPage> createState() =>
      _ViewReportTimekeepingPageState();
}

class _ViewReportTimekeepingPageState extends State<ViewReportTimekeepingPage> {
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
      appBar: ViewReportTimekeepingAppBar(title: Constants.titleViewReport),
      body: ViewReportTimekeepingBody(counter: _counter),
      floatingActionButton: ViewReportTimekeepingFab(
        onPressed: _incrementCounter,
      ),
    );
  }
}

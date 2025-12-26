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
  late DatePickerViewModel _datePickerViewModel;
  late ColorScheme _colorScheme;
  late Size _size;
  int _counter = 0;

  void _incrementCounter() {
    _viewReportViewModel.incrementCounter();
  }

  void _resetDate() {
    _datePickerViewModel.resetDate();
  }

  @override
  void initState() {
    _viewReportViewModel = context.readViewReportVM();
    _datePickerViewModel = context.readDatePickerVM();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resetDate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _viewReportViewModel = context.watchViewReportVM();
    _datePickerViewModel = context.watchDatePickerVM();

    _counter = _viewReportViewModel.counter;

    return Scaffold(
      backgroundColor: _colorScheme.surface,
      appBar: ViewReportAccountingAppBar(title: Constants.titleViewReport),
      body: ViewReportAccountingBody(counter: _counter),
      floatingActionButton: ViewReportAccountingFab(
        onPressed: _incrementCounter,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _colorScheme = context.contextColorScheme();
    _size = context.contextSize();
    super.didChangeDependencies();
  }
}
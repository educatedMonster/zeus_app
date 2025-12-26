import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zeus_app/core/constants/app_strings.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../../../../shared/viewmodels/date_picker_view_model.dart';
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
      appBar: ViewReportBanquetAppBar(title: Constants.titleViewReport),
      body: ViewReportBanquetBody(counter: _counter),
      floatingActionButton: ViewReportBanquetFab(onPressed: _incrementCounter),
    );
  }

  @override
  void didChangeDependencies() {
    _colorScheme = context.contextColorScheme();
    _size = context.contextSize();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

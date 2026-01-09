import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zeus_app/core/constants/app_strings.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../../../../shared/viewmodels/date_picker_view_model.dart';
import '../../../viewmodel/view_report_view_model.dart';
import 'widgets/view_report_timekeeping_app_bar.dart';
import 'widgets/view_report_timekeeping_body.dart';
import 'widgets/view_report_timekeeping_fab.dart';

@RoutePage()
class ViewReportTimekeepingPage extends StatefulWidget {
  final String property;
  final String module;

  const ViewReportTimekeepingPage({
    super.key,
    required this.property,
    required this.module,
  });

  @override
  State<ViewReportTimekeepingPage> createState() =>
      _ViewReportTimekeepingPageState();
}

class _ViewReportTimekeepingPageState extends State<ViewReportTimekeepingPage> {
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
  void didChangeDependencies() {
    _colorScheme = context.contextColorScheme();
    _size = context.contextSize();
    super.didChangeDependencies();
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
      appBar: ViewReportTimekeepingAppBar(title: Constants.titleViewReport),
      body: ViewReportTimekeepingBody(
        height: _size.height,
        property: widget.property,
        module: widget.module,
        counter: _counter,
      ),
      floatingActionButton: ViewReportTimekeepingFab(
        onPressed: _incrementCounter,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

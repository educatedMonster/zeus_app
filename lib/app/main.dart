import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:zeus_app/features/approval/viewmodel/approval_view_model.dart';
import 'package:zeus_app/features/report/viewmodel/report_view_model.dart';
import 'package:zeus_app/features/sample/viewmodel/sample_view_model.dart';

import '../features/dashboard/viewmodel/dashboard_view_model.dart';
import '../features/purchase_requests/viewmodel/purchase_request_view_model.dart';
import '../features/view_report/viewmodel/view_report_view_model.dart';
import '../shared/viewmodels/date_picker_view_model.dart';
import '../shared/viewmodels/file_format_dropdown_view_model.dart';
import '../shared/viewmodels/report_type_dropdown_view_model.dart';
import 'app.dart';

void main() {
  final registerProviders = <SingleChildWidget>[
    ChangeNotifierProvider(create: (_) => SampleViewModel()),
    ChangeNotifierProvider(create: (_) => DashboardViewModel()),
    ChangeNotifierProvider(create: (_) => ApprovalViewModel()),
    ChangeNotifierProvider(create: (_) => ReportViewModel()),
    ChangeNotifierProvider(create: (_) => ViewReportViewModel()),
    ChangeNotifierProvider(create: (_) => DatePickerViewModel()),
    ChangeNotifierProvider(create: (_) => ReportTypeDropdownViewModel()),
    ChangeNotifierProvider(create: (_) => FileFormatDropdownViewModel()),
    ChangeNotifierProvider(create: (_) => PurchaseRequestViewModel()),
  ]; //

  runApp(MultiProvider(providers: registerProviders, child: MyApp()));
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:zeus_app/features/approval/viewmodel/approval_view_model.dart';
import 'package:zeus_app/features/report/viewmodel/report_view_model.dart';
import 'package:zeus_app/features/view_report/viewmodel/view_report_view_model.dart';

import '../features/dashboard/viewmodel/dashboard_view_model.dart';
import 'app.dart';

void main() {
  final registerProviders = <SingleChildWidget>[
    ChangeNotifierProvider(create: (_) => DashboardViewModel()),
    ChangeNotifierProvider(create: (_) => ApprovalViewModel()),
    ChangeNotifierProvider(create: (_) => ReportViewModel()),
    ChangeNotifierProvider(create: (_) => ViewReportViewModel()),
  ]; //

  runApp(MultiProvider(providers: registerProviders, child: MyApp()));
}

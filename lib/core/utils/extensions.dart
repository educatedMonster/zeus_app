import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeus_app/features/approval/viewmodel/approval_view_model.dart';

import '../../features/dashboard/viewmodel/dashboard_view_model.dart';
import '../../features/report/viewmodel/report_view_model.dart';
import '../../features/sample/viewmodel/sample_view_model.dart';
import '../../features/view_report/viewmodel/view_report_view_model.dart';

extension ContextExtensions on BuildContext {
  FocusScopeNode contextCurrentFocus() => FocusScope.of(this);

  OverlayState contextOverlayState() => Overlay.of(this, rootOverlay: true);

  MediaQueryData mediaQueryData() => MediaQuery.of(this);

  double insetsBottom() => mediaQueryData().viewInsets.bottom;

  Size contextSize() => MediaQuery.sizeOf(this);

  double contextWidth() => contextSize().width;

  double contextHeight() => contextSize().height;

  ThemeData contextTheme() => Theme.of(this);

  ColorScheme contextColorScheme() => contextTheme().colorScheme;

  DashboardViewModel readDashboardVM() => read<DashboardViewModel>();

  DashboardViewModel watchDashboardVM() => watch<DashboardViewModel>();

  ReportViewModel readReportVM() => read<ReportViewModel>();

  ReportViewModel watchReportVM() => watch<ReportViewModel>();

  ViewReportViewModel readViewReportVM() => read<ViewReportViewModel>();

  ViewReportViewModel watchViewReportVM() => watch<ViewReportViewModel>();

  ApprovalViewModel readApprovalVM() => read<ApprovalViewModel>();

  ApprovalViewModel watchApprovalVM() => watch<ApprovalViewModel>();

  SampleViewModel readSampleVM() => read<SampleViewModel>();

  SampleViewModel watchSampleVM() => watch<SampleViewModel>();
}

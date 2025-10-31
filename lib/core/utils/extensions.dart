import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/approval/viewmodel/approval_view_model.dart';
import '../../features/dashboard/viewmodel/dashboard_view_model.dart';
import '../../features/purchase_requests/viewmodel/purchase_request_view_model.dart';
import '../../features/report/viewmodel/report_view_model.dart';
import '../../features/sample/viewmodel/sample_view_model.dart';
import '../../features/view_report/viewmodel/view_report_view_model.dart';

extension ContextExtensions on BuildContext {
  // Focus
  FocusScopeNode contextCurrentFocus() => FocusScope.of(this);

  // Overlay
  OverlayState contextOverlayState() => Overlay.of(this, rootOverlay: true)!;

  // MediaQuery
  MediaQueryData mediaQueryData() => MediaQuery.of(this);
  double insetsBottom() => mediaQueryData().viewInsets.bottom;
  Size contextSize() => MediaQuery.sizeOf(this);
  double contextWidth() => contextSize().width;
  double contextHeight() => contextSize().height;

  // Theme
  ThemeData contextTheme() => Theme.of(this);
  ColorScheme contextColorScheme() => contextTheme().colorScheme;

  // Dashboard ViewModel
  DashboardViewModel readDashboardVM() => read<DashboardViewModel>();
  DashboardViewModel watchDashboardVM() => watch<DashboardViewModel>();

  // Report ViewModel
  ReportViewModel readReportVM() => read<ReportViewModel>();
  ReportViewModel watchReportVM() => watch<ReportViewModel>();

  // View Report ViewModel
  ViewReportViewModel readViewReportVM() => read<ViewReportViewModel>();
  ViewReportViewModel watchViewReportVM() => watch<ViewReportViewModel>();

  // Approval ViewModel
  ApprovalViewModel readApprovalVM() => read<ApprovalViewModel>();
  ApprovalViewModel watchApprovalVM() => watch<ApprovalViewModel>();

  // Purchase Request ViewModel
  PurchaseRequestViewModel readPurchaseRequestsVM() => read<PurchaseRequestViewModel>();
  PurchaseRequestViewModel watchPurchaseRequestsVM() => watch<PurchaseRequestViewModel>();

  // Sample ViewModel
  SampleViewModel readSampleVM() => read<SampleViewModel>();
  SampleViewModel watchSampleVM() => watch<SampleViewModel>();
}

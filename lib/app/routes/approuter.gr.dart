// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:zeus_app/features/approval/view/approval_page.dart' as _i1;
import 'package:zeus_app/features/approval/view/pages/approved_approval_page.dart'
    as _i2;
import 'package:zeus_app/features/approval/view/pages/pending_approval_page.dart'
    as _i4;
import 'package:zeus_app/features/approval/view/pages/rejected_approval_page.dart'
    as _i6;
import 'package:zeus_app/features/approval/view/pages/returned_approval_page.dart'
    as _i8;
import 'package:zeus_app/features/dashboard/view/dashboard_page.dart' as _i3;
import 'package:zeus_app/features/purchase_requests/view/purchase_request_page.dart'
    as _i5;
import 'package:zeus_app/features/report/view/report_page.dart' as _i7;
import 'package:zeus_app/features/sample/view/sample_page.dart' as _i9;
import 'package:zeus_app/features/view_report/view/pages/accounting/view_report_accounting_page.dart'
    as _i10;
import 'package:zeus_app/features/view_report/view/pages/banquet/view_report_banquet_page.dart'
    as _i11;
import 'package:zeus_app/features/view_report/view/pages/pos/view_report_pos_page.dart'
    as _i12;
import 'package:zeus_app/features/view_report/view/pages/room/view_report_room_page.dart'
    as _i13;
import 'package:zeus_app/features/view_report/view/pages/timekeeping/view_report_timekeeping_page.dart'
    as _i14;
import 'package:zeus_app/features/web_socket_and_printer/view/web_socket_and_printer_page.dart'
    as _i15;

/// generated route for
/// [_i1.ApprovalPage]
class ApprovalRoute extends _i16.PageRouteInfo<void> {
  const ApprovalRoute({List<_i16.PageRouteInfo>? children})
    : super(ApprovalRoute.name, initialChildren: children);

  static const String name = 'ApprovalRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i1.ApprovalPage();
    },
  );
}

/// generated route for
/// [_i2.ApprovedApprovalPage]
class ApprovedApprovalRoute extends _i16.PageRouteInfo<void> {
  const ApprovedApprovalRoute({List<_i16.PageRouteInfo>? children})
    : super(ApprovedApprovalRoute.name, initialChildren: children);

  static const String name = 'ApprovedApprovalRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i2.ApprovedApprovalPage();
    },
  );
}

/// generated route for
/// [_i3.DashboardPage]
class DashboardRoute extends _i16.PageRouteInfo<void> {
  const DashboardRoute({List<_i16.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardPage();
    },
  );
}

/// generated route for
/// [_i4.PendingApprovalPage]
class PendingApprovalRoute extends _i16.PageRouteInfo<void> {
  const PendingApprovalRoute({List<_i16.PageRouteInfo>? children})
    : super(PendingApprovalRoute.name, initialChildren: children);

  static const String name = 'PendingApprovalRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i4.PendingApprovalPage();
    },
  );
}

/// generated route for
/// [_i5.PurchaseRequestPage]
class PurchaseRequestRoute extends _i16.PageRouteInfo<void> {
  const PurchaseRequestRoute({List<_i16.PageRouteInfo>? children})
    : super(PurchaseRequestRoute.name, initialChildren: children);

  static const String name = 'PurchaseRequestRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i5.PurchaseRequestPage();
    },
  );
}

/// generated route for
/// [_i6.RejectedApprovalPage]
class RejectedApprovalRoute extends _i16.PageRouteInfo<void> {
  const RejectedApprovalRoute({List<_i16.PageRouteInfo>? children})
    : super(RejectedApprovalRoute.name, initialChildren: children);

  static const String name = 'RejectedApprovalRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i6.RejectedApprovalPage();
    },
  );
}

/// generated route for
/// [_i7.ReportPage]
class ReportRoute extends _i16.PageRouteInfo<void> {
  const ReportRoute({List<_i16.PageRouteInfo>? children})
    : super(ReportRoute.name, initialChildren: children);

  static const String name = 'ReportRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i7.ReportPage();
    },
  );
}

/// generated route for
/// [_i8.ReturnedApprovalPage]
class ReturnedApprovalRoute extends _i16.PageRouteInfo<void> {
  const ReturnedApprovalRoute({List<_i16.PageRouteInfo>? children})
    : super(ReturnedApprovalRoute.name, initialChildren: children);

  static const String name = 'ReturnedApprovalRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i8.ReturnedApprovalPage();
    },
  );
}

/// generated route for
/// [_i9.SamplePage]
class SampleRoute extends _i16.PageRouteInfo<void> {
  const SampleRoute({List<_i16.PageRouteInfo>? children})
    : super(SampleRoute.name, initialChildren: children);

  static const String name = 'SampleRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i9.SamplePage();
    },
  );
}

/// generated route for
/// [_i10.ViewReportAccountingPage]
class ViewReportAccountingRoute
    extends _i16.PageRouteInfo<ViewReportAccountingRouteArgs> {
  ViewReportAccountingRoute({
    _i17.Key? key,
    required String property,
    required String module,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         ViewReportAccountingRoute.name,
         args: ViewReportAccountingRouteArgs(
           key: key,
           property: property,
           module: module,
         ),
         initialChildren: children,
       );

  static const String name = 'ViewReportAccountingRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewReportAccountingRouteArgs>();
      return _i10.ViewReportAccountingPage(
        key: args.key,
        property: args.property,
        module: args.module,
      );
    },
  );
}

class ViewReportAccountingRouteArgs {
  const ViewReportAccountingRouteArgs({
    this.key,
    required this.property,
    required this.module,
  });

  final _i17.Key? key;

  final String property;

  final String module;

  @override
  String toString() {
    return 'ViewReportAccountingRouteArgs{key: $key, property: $property, module: $module}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ViewReportAccountingRouteArgs) return false;
    return key == other.key &&
        property == other.property &&
        module == other.module;
  }

  @override
  int get hashCode => key.hashCode ^ property.hashCode ^ module.hashCode;
}

/// generated route for
/// [_i11.ViewReportBanquetPage]
class ViewReportBanquetRoute
    extends _i16.PageRouteInfo<ViewReportBanquetRouteArgs> {
  ViewReportBanquetRoute({
    _i17.Key? key,
    required String property,
    required String module,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         ViewReportBanquetRoute.name,
         args: ViewReportBanquetRouteArgs(
           key: key,
           property: property,
           module: module,
         ),
         initialChildren: children,
       );

  static const String name = 'ViewReportBanquetRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewReportBanquetRouteArgs>();
      return _i11.ViewReportBanquetPage(
        key: args.key,
        property: args.property,
        module: args.module,
      );
    },
  );
}

class ViewReportBanquetRouteArgs {
  const ViewReportBanquetRouteArgs({
    this.key,
    required this.property,
    required this.module,
  });

  final _i17.Key? key;

  final String property;

  final String module;

  @override
  String toString() {
    return 'ViewReportBanquetRouteArgs{key: $key, property: $property, module: $module}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ViewReportBanquetRouteArgs) return false;
    return key == other.key &&
        property == other.property &&
        module == other.module;
  }

  @override
  int get hashCode => key.hashCode ^ property.hashCode ^ module.hashCode;
}

/// generated route for
/// [_i12.ViewReportPosPage]
class ViewReportPosRoute extends _i16.PageRouteInfo<ViewReportPosRouteArgs> {
  ViewReportPosRoute({
    _i17.Key? key,
    required String property,
    required String module,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         ViewReportPosRoute.name,
         args: ViewReportPosRouteArgs(
           key: key,
           property: property,
           module: module,
         ),
         initialChildren: children,
       );

  static const String name = 'ViewReportPosRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewReportPosRouteArgs>();
      return _i12.ViewReportPosPage(
        key: args.key,
        property: args.property,
        module: args.module,
      );
    },
  );
}

class ViewReportPosRouteArgs {
  const ViewReportPosRouteArgs({
    this.key,
    required this.property,
    required this.module,
  });

  final _i17.Key? key;

  final String property;

  final String module;

  @override
  String toString() {
    return 'ViewReportPosRouteArgs{key: $key, property: $property, module: $module}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ViewReportPosRouteArgs) return false;
    return key == other.key &&
        property == other.property &&
        module == other.module;
  }

  @override
  int get hashCode => key.hashCode ^ property.hashCode ^ module.hashCode;
}

/// generated route for
/// [_i13.ViewReportRoomPage]
class ViewReportRoomRoute extends _i16.PageRouteInfo<ViewReportRoomRouteArgs> {
  ViewReportRoomRoute({
    _i17.Key? key,
    required String property,
    required String module,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         ViewReportRoomRoute.name,
         args: ViewReportRoomRouteArgs(
           key: key,
           property: property,
           module: module,
         ),
         initialChildren: children,
       );

  static const String name = 'ViewReportRoomRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewReportRoomRouteArgs>();
      return _i13.ViewReportRoomPage(
        key: args.key,
        property: args.property,
        module: args.module,
      );
    },
  );
}

class ViewReportRoomRouteArgs {
  const ViewReportRoomRouteArgs({
    this.key,
    required this.property,
    required this.module,
  });

  final _i17.Key? key;

  final String property;

  final String module;

  @override
  String toString() {
    return 'ViewReportRoomRouteArgs{key: $key, property: $property, module: $module}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ViewReportRoomRouteArgs) return false;
    return key == other.key &&
        property == other.property &&
        module == other.module;
  }

  @override
  int get hashCode => key.hashCode ^ property.hashCode ^ module.hashCode;
}

/// generated route for
/// [_i14.ViewReportTimekeepingPage]
class ViewReportTimekeepingRoute
    extends _i16.PageRouteInfo<ViewReportTimekeepingRouteArgs> {
  ViewReportTimekeepingRoute({
    _i17.Key? key,
    required String property,
    required String module,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         ViewReportTimekeepingRoute.name,
         args: ViewReportTimekeepingRouteArgs(
           key: key,
           property: property,
           module: module,
         ),
         initialChildren: children,
       );

  static const String name = 'ViewReportTimekeepingRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewReportTimekeepingRouteArgs>();
      return _i14.ViewReportTimekeepingPage(
        key: args.key,
        property: args.property,
        module: args.module,
      );
    },
  );
}

class ViewReportTimekeepingRouteArgs {
  const ViewReportTimekeepingRouteArgs({
    this.key,
    required this.property,
    required this.module,
  });

  final _i17.Key? key;

  final String property;

  final String module;

  @override
  String toString() {
    return 'ViewReportTimekeepingRouteArgs{key: $key, property: $property, module: $module}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ViewReportTimekeepingRouteArgs) return false;
    return key == other.key &&
        property == other.property &&
        module == other.module;
  }

  @override
  int get hashCode => key.hashCode ^ property.hashCode ^ module.hashCode;
}

/// generated route for
/// [_i15.WebSocketAndPrinterPage]
class WebSocketAndPrinterRoute extends _i16.PageRouteInfo<void> {
  const WebSocketAndPrinterRoute({List<_i16.PageRouteInfo>? children})
    : super(WebSocketAndPrinterRoute.name, initialChildren: children);

  static const String name = 'WebSocketAndPrinterRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i15.WebSocketAndPrinterPage();
    },
  );
}

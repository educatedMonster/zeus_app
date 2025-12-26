import 'package:auto_route/auto_route.dart';
import 'package:zeus_app/features/web_socket_and_printer/view/web_socket_and_printer_page.dart';

import 'approuter.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    CustomRoute(
      path: "/dashboard",
      initial: true,
      page: DashboardRoute.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),

    CustomRoute(
      path: "/approval",
      page: ApprovalRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      children: [
        CustomRoute(
          page: PendingApprovalRoute.page,
          path: 'pending',
          initial: true,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: ApprovedApprovalRoute.page,
          path: 'approved',
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: ReturnedApprovalRoute.page,
          path: 'returned',
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: RejectedApprovalRoute.page,
          path: 'rejected',
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
      ],
    ),

    CustomRoute(
      path: "/report",
      page: ReportRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),

    CustomRoute(
      path: "/report-room",
      page: ViewReportRoomRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),

    CustomRoute(
      path: "/view-report-banquet",
      page: ViewReportBanquetRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),

    CustomRoute(
      path: "/view-report-pos",
      page: ViewReportPosRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),

    CustomRoute(
      path: "/view-report-accounting",
      page: ViewReportAccountingRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),

    CustomRoute(
      path: "/view-report-timekeeping",
      page: ViewReportTimekeepingRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),

    CustomRoute(
      path: "/web-socket-and-printer",
      page: WebSocketAndPrinterRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),
  ];
}

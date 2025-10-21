import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zeus_app/core/utils/extensions.dart';
import 'package:zeus_app/features/approval/view/widgets/approval_app_bar.dart';
import 'package:zeus_app/features/approval/view/widgets/approval_fab.dart';
import 'package:zeus_app/features/approval/viewmodel/approval_view_model.dart';
import 'package:zeus_app/shared/widgets/app_drawer.dart';

import '../../../app/routes/approuter.gr.dart';

@RoutePage()
class ApprovalPage extends StatefulWidget {
  const ApprovalPage({super.key});

  @override
  State<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late ApprovalViewModel _approvalViewModel;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late ColorScheme _colorScheme;
  late Size _size;
  int _counter = 0;
  late final TabController _tabController;
  bool _isSynced = false;
  final List<String> _tabs = ['Pending', 'Approved', 'Returned', 'Rejected'];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _initControllers();
    _initTabController();

    _approvalViewModel = context.read<ApprovalViewModel>();

    _counter = _approvalViewModel.counter;
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _colorScheme = context.contextColorScheme();
    _size = context.contextSize();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _approvalViewModel = context.watch<ApprovalViewModel>();

    _counter = _approvalViewModel.counter;

    return AutoTabsRouter(
      routes: const [
        PendingApprovalRoute(),
        ApprovedApprovalRoute(),
        ReturnedApprovalRoute(),
        RejectedApprovalRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        // Only sync once (avoid multiple listeners)
        if (!_isSynced) {
          _isSynced = true;

          // Flutter → AutoRoute
          _tabController.addListener(() {
            if (_tabController.indexIsChanging) {
              tabsRouter.setActiveIndex(_tabController.index);
            }
          });

          // AutoRoute → Flutter
          tabsRouter.addListener(() {
            if (_tabController.index != tabsRouter.activeIndex) {
              _tabController.animateTo(tabsRouter.activeIndex);
            }
          });
        }

        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          key: _scaffoldKey,
          appBar: ApprovalAppBar(
            title: 'Approvals',
            leadingWidget: IconButton(
              onPressed: () async {
                if (!_scaffoldKey.currentState!.isDrawerOpen) {
                  _approvalViewModel.setSelectedDrawerIndex(-1);
                  _scaffoldKey.currentState!.openDrawer();
                }
              },
              icon: Padding(
                padding: const EdgeInsets.only(left: 8.0).r,
                child: Icon(
                  Icons.menu,
                  size: 20.0.r,
                  color: _colorScheme.onSurface,
                ),
              ),
            ),
            tabController: _tabController,
            tabs: _tabs,
          ),
          drawer: AppDrawer(scaffoldKey: _scaffoldKey),
          body: child,
          floatingActionButton: ApprovalFab(onPressed: _incrementCounter),
        );
      },
    );
  }

  void _incrementCounter() async {
    _approvalViewModel.incrementCounter();
  }

  void _initControllers() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  void _initTabController() {
    _tabController = TabController(length: _tabs.length, vsync: this);
  }
}

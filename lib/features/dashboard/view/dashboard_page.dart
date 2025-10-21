import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../../shared/widgets/app_drawer.dart';
import '../viewmodel/dashboard_view_model.dart';
import 'widgets/dashboard_app_bar.dart';
import 'widgets/dashboard_body.dart';
import 'widgets/dashboard_fab.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with WidgetsBindingObserver {
  late DashboardViewModel _dashboardViewModel;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late ColorScheme _colorScheme;
  late Size _size;
  int _counter = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _initControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dashboardViewModel = context.watchDashboardVM();

    _counter = _dashboardViewModel.counter;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      key: _scaffoldKey,
      appBar: DashboardAppBar(
        title: 'Dashboard',
        leadingWidget: IconButton(
          onPressed: () async {
            if (!_scaffoldKey.currentState!.isDrawerOpen) {
              _dashboardViewModel.setSelectedDrawerIndex(-1);
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
      ),
      drawer: AppDrawer(scaffoldKey: _scaffoldKey),
      body: DashboardBody(counter: _counter),
      floatingActionButton: DashboardFab(onPressed: _incrementCounter),
    );
  }

  @override
  void didChangeDependencies() {
    _colorScheme = context.contextColorScheme();
    _size = context.contextSize();
    super.didChangeDependencies();
  }

  void _incrementCounter() {
    _dashboardViewModel.incrementCounter();
  }

  void _initControllers() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }
}

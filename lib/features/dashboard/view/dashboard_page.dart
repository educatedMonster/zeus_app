import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../../core/constants/app_text_styles.dart';
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
  List<String> properties = ["All", "Property A", "Property B", "Property C"];
  late final String _selectedProperty = properties[0];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _dashboardViewModel = context.readDashboardVM();

    _initControllers();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dashboardViewModel.setSelectedProperty(_selectedProperty);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dashboardViewModel = context.watchDashboardVM();

    _counter = _dashboardViewModel.counter;

    return Scaffold(
      backgroundColor: _colorScheme.surface,
      key: _scaffoldKey,
      appBar: DashboardAppBar(
        colorScheme: _colorScheme,
        title: 'Dashboard',
        leadingWidget: IconButton(
          onPressed: () async {
            if (!_scaffoldKey.currentState!.isDrawerOpen) {
              // _dashboardViewModel.setSelectedDrawerIndex(-1);
              _scaffoldKey.currentState!.openDrawer();
            }
          },
          icon: Padding(
            padding: const EdgeInsets.only(left: 8.0).r,
            child: menuButton(),
          ),
        ),
      ),
      drawer: AppDrawer(
        colorScheme: _colorScheme,
        size: _size,
        scaffoldKey: _scaffoldKey,
        properties: properties,
      ),
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

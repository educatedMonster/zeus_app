import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/utils/extensions.dart';
import 'package:zeus_app/features/dashboard/viewmodel/dashboard_view_model.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../viewmodel/report_view_model.dart';
import 'widgets/report_app_bar.dart';
import 'widgets/report_body.dart';
import 'widgets/report_fab.dart';

@RoutePage()
class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with WidgetsBindingObserver {
  late ReportViewModel _reportViewModel;
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
    _reportViewModel = context.readReportVM();
    _dashboardViewModel = context.readDashboardVM();

    _initControllers();

    _counter = _reportViewModel.counter;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dashboardViewModel.setSelectedProperty(_selectedProperty);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _colorScheme = context.contextColorScheme();
    _size = context.contextSize();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _reportViewModel = context.watchReportVM();

    _counter = _reportViewModel.counter;

    return Scaffold(
      backgroundColor: _colorScheme.surface,
      key: _scaffoldKey,
      appBar: ReportAppBar(
        title: Constants.titleReports,
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
      body: ReportBody(height: _size.height, counter: _counter),
      floatingActionButton: ReportFab(onPressed: _incrementCounter),
    );
  }

  void _incrementCounter() {
    _reportViewModel.incrementCounter();
  }

  void _initControllers() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }
}

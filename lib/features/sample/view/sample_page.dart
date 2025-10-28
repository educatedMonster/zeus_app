import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zeus_app/core/constants/app_strings.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import 'widgets/sample_app_bar.dart';
import 'widgets/sample_body.dart';
import 'widgets/sample_fab.dart';
import '../viewmodel/sample_view_model.dart';

@RoutePage()
class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  late SampleViewModel _sampleViewModel;
  int _counter = 0;

  void _incrementCounter() {
    _sampleViewModel.incrementCounter();
  }

  @override
  void initState() {
    _sampleViewModel = context.readSampleVM();
    _counter = _sampleViewModel.counter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _sampleViewModel = context.watchSampleVM();
    _counter = _sampleViewModel.counter;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: SampleAppBar(title: Constants.titleViewReport),
      body: SampleBody(counter: _counter),
      floatingActionButton: SampleFab(onPressed: _incrementCounter),
    );
  }
}

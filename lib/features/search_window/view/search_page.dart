import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/extensions.dart';
import '../viewmodel/search_view_model.dart';
import 'widgets/search_window_app_bar.dart';
import 'widgets/search_window_body.dart';
import 'widgets/search_window_fab.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchViewModel _searchViewModel;
  int _counter = 0;

  void _incrementCounter() {
    _searchViewModel.incrementCounter();
  }

  @override
  void initState() {
    _searchViewModel = context.readSearchVM();
    _counter = _searchViewModel.counter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _searchViewModel = context.watchSearchVM();
    _counter = _searchViewModel.counter;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: SearchWindowAppBar(title: 'SEARCH WINDOW'),
      body: SearchWindowBody(counter: _counter),
      floatingActionButton: SearchWindowFab(onPressed: _incrementCounter),
    );
  }
}

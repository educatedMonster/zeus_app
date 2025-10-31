import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zeus_app/core/constants/app_strings.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import 'widgets/purchase_request_app_bar.dart';
import 'widgets/purchase_requests_body.dart';
import 'widgets/purchase_requests_fab.dart';
import '../viewmodel/purchase_request_view_model.dart';

@RoutePage()
class PurchaseRequestPage extends StatefulWidget {
  const PurchaseRequestPage({super.key});

  @override
  State<PurchaseRequestPage> createState() => _PurchaseRequestPageState();
}

class _PurchaseRequestPageState extends State<PurchaseRequestPage> {
  late PurchaseRequestViewModel _purchaseRequestViewModel;
  int _counter = 0;

  void _incrementCounter() {
    _purchaseRequestViewModel.incrementCounter();
  }

  @override
  void initState() {
    _purchaseRequestViewModel = context.readPurchaseRequestsVM();
    _counter = _purchaseRequestViewModel.counter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _purchaseRequestViewModel = context.watchPurchaseRequestsVM();
    _counter = _purchaseRequestViewModel.counter;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PurchaseRequestAppBar(title: Constants.titleViewReport),
      body: PurchaseRequestsBody(counter: _counter),
      floatingActionButton: PurchaseRequestsFab(onPressed: _incrementCounter),
    );
  }
}

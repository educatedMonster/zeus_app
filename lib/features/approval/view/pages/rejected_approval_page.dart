import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/approval_view_model.dart';
import '../widgets/approval_high_low_button.dart';
import '../widgets/approval_purchase_order_data_table_card.dart';
import '../widgets/approval_purchase_request_data_table_card.dart';

@RoutePage()
class RejectedApprovalPage extends StatefulWidget {
  const RejectedApprovalPage({super.key});

  @override
  State<RejectedApprovalPage> createState() => _RejectedApprovalPageState();
}

class _RejectedApprovalPageState extends State<RejectedApprovalPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<String> _tabs = ['High', 'Low'];

  void _initTabController() {
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void initState() {
    _initTabController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parentController = context
        .select<ApprovalViewModel, ScrollController>(
          (vm) => vm.rejectedParentController,
    );
    final childController = context
        .select<ApprovalViewModel, ScrollController>(
          (vm) => vm.childController,
        );

    return SingleChildScrollView(
      controller: parentController,
      physics: const ClampingScrollPhysics(),
      scrollDirection: .vertical,
      child: Column(
        children: [
          ApprovalHighLowButton(
            tabController: _tabController,
            options: _tabs,
          ),

          ApprovalPurchaseRequestDataTableCard(parentController: parentController, childController:  childController,),

          ApprovalPurchaseOrderDataTableCard(parentController: parentController, childController:  childController),

          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ],
      ),
    );
  }
}

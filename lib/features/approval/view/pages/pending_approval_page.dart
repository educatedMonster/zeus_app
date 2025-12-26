import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeus_app/features/approval/view/widgets/approval_high_low_button.dart';

import '../../../../core/utils/extensions.dart';
import '../../viewmodel/approval_view_model.dart';
import '../widgets/approval_purchase_order_data_table_card.dart';
import '../widgets/approval_purchase_request_data_table_card.dart';

@RoutePage()
class PendingApprovalPage extends StatefulWidget {
  const PendingApprovalPage({super.key});

  @override
  State<PendingApprovalPage> createState() => _PendingApprovalPageState();
}

class _PendingApprovalPageState extends State<PendingApprovalPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<String> _tabs = ['High', 'Low'];
  late Size _size;

  void _initTabController() {
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void initState() {
    _initTabController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final parentController = context
        .select<ApprovalViewModel, ScrollController>(
          (vm) => vm.pendingParentController,
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

          ApprovalPurchaseRequestDataTableCard(parentController: parentController, childController:  childController),

          ApprovalPurchaseOrderDataTableCard(parentController: parentController, childController:  childController),

          SizedBox(height: _size.height * 0.25),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _size = context.contextSize();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class _PendingApprovalPageState extends State<PendingApprovalPage>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = ['High', 'Low'];
  late final String _calendarView = _tabs[0];
  late Size _size;
  late ApprovalViewModel _approvalVM;

  @override
  void didChangeDependencies() {
    _size = context.contextSize();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _approvalVM = context.readApprovalVM();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _approvalVM.selectedSegmentedButton(_calendarView);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final (parentController, childController) = context
        .select<ApprovalViewModel, (ScrollController, ScrollController)>(
          (vm) => (vm.pendingParentController, vm.childController),
        );

    return SingleChildScrollView(
      controller: parentController,
      physics: const ClampingScrollPhysics(),
      scrollDirection: .vertical,
      child: Column(
        children: [
          ApprovalHighLowButton(options: _tabs),

          ApprovalPurchaseRequestDataTableCard(
            parentController: parentController,
            childController: childController,
          ),

          ApprovalPurchaseOrderDataTableCard(
            parentController: parentController,
            childController: childController,
          ),

          SizedBox(height: _size.height * 0.25.r),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

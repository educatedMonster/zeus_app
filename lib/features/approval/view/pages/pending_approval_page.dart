import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zeus_app/features/approval/view/widgets/approval_high_low_button.dart';

import '../widgets/approval_purchase_order_data_table_card.dart';
import '../widgets/approval_purchase_request_data_table_card.dart';

@RoutePage()
class PendingApprovalPage extends StatefulWidget {
  const PendingApprovalPage({super.key});

  @override
  State<PendingApprovalPage> createState() => _PendingApprovalPageState();
}

class _PendingApprovalPageState extends State<PendingApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ApprovalHighLowButton(options: ['High', 'Low']),

          ApprovalPurchaseRequestDataTableCard(),

          ApprovalPurchaseOrderDataTableCard(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.25)
        ],
      ),
    );
  }
}

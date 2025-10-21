import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../widgets/approval_high_low_button.dart';
import '../widgets/approval_purchase_order_data_table_card.dart';
import '../widgets/approval_purchase_request_data_table_card.dart';

@RoutePage()
class ReturnedApprovalPage extends StatelessWidget {
  const ReturnedApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ApprovalHighLowButton(options: ['High', 'Low']),

          ApprovalPurchaseRequestDataTableCard(),

          ApprovalPurchaseOrderDataTableCard(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ],
      ),
    );
  }
}

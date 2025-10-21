import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/routes/approuter.gr.dart';

class ApprovalBody extends StatelessWidget {
  final int counter;
  final List<String> tabs;

  const ApprovalBody({super.key, required this.counter, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        PendingApprovalRoute(),
        ApprovedApprovalRoute(),
        ReturnedApprovalRoute(),
        RejectedApprovalRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        // Provide the tabsRouter to children
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          body: Column(
            children: [
              // Custom tab bar (no TabController!)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(tabs.length, (index) {
                  final isActive = tabsRouter.activeIndex == index;
                  final isPending = tabs[index] == 'Pending';

                  return GestureDetector(
                    onTap: () => tabsRouter.setActiveIndex(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8.0.r,
                      children: [
                        Row(
                          children: [
                            Text(
                              tabs[index],
                              style: TextStyle(
                                color: isActive
                                    ? Colors.black87
                                    : Colors.grey.shade500,
                                fontWeight: isActive
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                            if (isPending)
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '1',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 2.5,
                          width: isActive ? 40 : 0,
                          color: isActive
                              ? Colors.indigo
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  );
                }),
              ),

              // Active tab content
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}

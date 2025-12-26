import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zeus_app/features/approval/viewmodel/approval_view_model.dart';

import '../../../../core/utils/extensions.dart';

class ApprovalHighLowButton extends StatelessWidget {
  final TabController tabController;
  final List<String> options;

  const ApprovalHighLowButton({
    super.key,
    required this.tabController,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();
    int segmentedButton = context.watchApprovalVM().segmentedButton;

    return Container(
      margin: const EdgeInsets.all(8.0).r,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(32.0.r),
        border: Border.all(color: colorScheme.surfaceContainer),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.10),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        labelColor: colorScheme.surfaceContainer,
        unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.50),
        indicatorSize: TabBarIndicatorSize.tab,
        // fill each tab
        indicatorPadding: EdgeInsets.zero,
        // no extra padding
        // indicatorWeight: 1,
        // prevent thin default line
        dividerColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        // no splash that looks like a line
        indicator: BoxDecoration(
          color: colorScheme.onSurface,
          borderRadius: BorderRadius.circular(32.0.r),
        ),
        labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        tabs: options
            .map(
              (tab) => Tab(
                child: Text(tab, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            )
            .toList(),
      ),
    );

    return Container(
      // width: width,
      margin: const EdgeInsets.all(8.0).r,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(30.0.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.surface,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / options.length;

          return Stack(
            children: [
              // Animated thumb (the highlighted background)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                left: segmentWidth * segmentedButton,
                child: Container(
                  width: segmentWidth,
                  height: kToolbarHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              // Labels
              Row(
                children: List.generate(options.length, (index) {
                  final isSelected = segmentedButton == index;

                  return Expanded(
                    child: InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () async {
                        context
                            .read<ApprovalViewModel>()
                            .selectedSegmentedButton(index);
                        debugPrint('${index}');
                      },
                      child: Container(
                        height: kToolbarHeight,
                        alignment: Alignment.center,
                        child: Text(
                          options[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.indigo
                                : Colors.grey.shade600,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontSize: 12.0.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

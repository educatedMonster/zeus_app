import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zeus_app/features/approval/viewmodel/approval_view_model.dart';

class ApprovalHighLowButton extends StatelessWidget {
  final List<String> options;

  const ApprovalHighLowButton({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    int segmentedButton = context.watch<ApprovalViewModel>().segmentedButton;

    return Container(
      height: kToolbarHeight,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(8.0).r,
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
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

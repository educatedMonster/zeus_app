import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zeus_app/features/dashboard/viewmodel/dashboard_view_model.dart';

class AnimatedLineProgressBar extends StatefulWidget {
  final String keyAnimation;
  final double value;
  final Color backgroundColor;
  final Color progressColor;

  const AnimatedLineProgressBar({
    super.key,
    required this.keyAnimation,
    required this.value,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  State<AnimatedLineProgressBar> createState() =>
      _AnimatedLineProgressBarState();
}

class _AnimatedLineProgressBarState extends State<AnimatedLineProgressBar>
    with SingleTickerProviderStateMixin {
  late DashboardViewModel _dashboardViewModel;
  late AnimationController _lineController;
  late Animation<double> _lineAnimation;
  bool _hasAnimated = false; // Prevents repeating animation
  double _oldValue = 0.0;

  @override
  void initState() {
    super.initState();
    _dashboardViewModel = context.read<DashboardViewModel>();

    _lineController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _lineAnimation =
        Tween<double>(begin: _oldValue, end: widget.value).animate(
          CurvedAnimation(parent: _lineController, curve: Curves.easeInOut),
        )..addListener(() {setState(() {});}); /// do not remove this
  }

  @override
  void didUpdateWidget(covariant AnimatedLineProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _oldValue = _lineAnimation.value;
      _startAnimation();
    }
  }

  void _startAnimation() {
    if (_hasAnimated) return;
    _hasAnimated = true;
    _lineController.forward(from: 0);
  }

  @override
  void dispose() {
    _lineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _dashboardViewModel = context.watch<DashboardViewModel>();

    return VisibilityDetector(
      key: Key(widget.keyAnimation),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) {
          _startAnimation();
        }
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 8.0.r,
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          FractionallySizedBox(
            widthFactor: _lineAnimation.value.clamp(0.0, 1.0),
            child: Container(
              height: 8.r,
              decoration: BoxDecoration(
                color: widget.progressColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 8.0.r,
              height: 5.0.r,
              decoration: BoxDecoration(
                color: widget.progressColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

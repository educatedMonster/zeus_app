import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/shared/dialogs/export_file_dialog.dart';

import '../../core/utils/extensions.dart';
import 'build_legend_dot.dart';

class BuildHeaderChart extends StatelessWidget {
  final String label;
  final Color? color;
  final String? caption;
  final Widget? icon;
  final VoidCallback? onIconPressed;

  const BuildHeaderChart({
    super.key,
    required this.label,
    this.color,
    this.caption,
    this.icon,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisAlignment: .start,
                crossAxisAlignment: .center,
                spacing: 8.0.r,
                children: [BuildLegendDot(color: color, label: label)],
              ),
              if (caption != null)
                Text(
                  '$caption',
                  style: TextStyle(fontSize: 10.0.sp, color: colorScheme.onSurface),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
            ],
          ),
        ),

        // if (icon != null) IconButton(onPressed: icon != null ? onIconPressed : null, icon: icon!),
        if (icon != null)
          IconButton(
            onPressed: icon != null
                ? () async {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const ExportFileDialog(),
                    );
                  }
                : null,
            icon: icon!,
          ),
      ],
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoRouteBreadcrumbs extends StatelessWidget {
  const AutoRouteBreadcrumbs({super.key});

  @override
  Widget build(BuildContext context) {
    final stack = AutoRouter.of(context).stack;

    // Skip first 2 routes
    final visibleRoutes = stack.skip(2).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
      child: Row(
        children: [
          for (int i = 0; i < visibleRoutes.length; i++) ...[
            GestureDetector(
              onTap: () {
                // Navigate back to the tapped route
                if (i < visibleRoutes.length - 1) {
                  AutoRouter.of(context).popUntilRouteWithName(visibleRoutes[i].name!);
                }
              },
              child: Text(
                visibleRoutes[i].name!.replaceAll('Route', ''),
                style: TextStyle(
                  color: i == visibleRoutes.length - 1
                      ? Colors.indigo
                      : Colors.indigo.shade500,
                  fontWeight: i == visibleRoutes.length - 1
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            if (i < visibleRoutes.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.chevron_right, size: 18, color: Colors.grey),
              ),
          ],
        ],
      ),
    );
  }
}

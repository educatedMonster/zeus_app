import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zeus_app/app/routes/approuter.gr.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../app/themes/theme_light.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';
import '../../core/constants/app_strings.dart';
import '../../features/dashboard/viewmodel/dashboard_view_model.dart';
import 'marquee_widget.dart';

class AppDrawer extends StatelessWidget {
  final ColorScheme colorScheme;
  final Size size;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<String> properties;

  const AppDrawer({
    super.key,
    required this.colorScheme,
    required this.size,
    required this.scaffoldKey,
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = context.watchDashboardVM();

    final (themeData, selectedProperty, selectedDrawerIndex) = context
        .select<DashboardViewModel, (ThemeData, String, int)>(
          (vm) => (vm.themeData, vm.selectedProperty, vm.selectedDrawerIndex),
        );

    // Define drawer items dynamically
    final drawerItems = <DrawerItem>[
      /// DASHBOARD
      DrawerItem(
        icon: Icons.print_outlined,
        selectedIcon: Icons.print,
        label: Constants.titleDashboard,
        onTap: () async {
          if (scaffoldKey.currentState!.isDrawerOpen) {
            scaffoldKey.currentState!.closeDrawer();
          }

          final routeData = context.routeData.router.current;
          if (routeData.name != 'DashboardRoute') {
            // context.router.pushPath('/dashboard');
            context.router.navigate(DashboardRoute());
          }
        },
      ),

      /// APPROVALS
      DrawerItem(
        icon: Icons.privacy_tip_outlined,
        selectedIcon: Icons.privacy_tip,
        label: Constants.titleApprovals,
        onTap: () async {
          if (scaffoldKey.currentState!.isDrawerOpen) {
            scaffoldKey.currentState!.closeDrawer();
          }

          // context.router.pushPath('/approval');
          context.router.navigate(ApprovalRoute());
        },
      ),

      /// REPORTS
      DrawerItem(
        icon: Icons.reviews_outlined,
        selectedIcon: Icons.reviews,
        label: Constants.titleReports,
        onTap: () async {
          if (scaffoldKey.currentState!.isDrawerOpen) {
            scaffoldKey.currentState!.closeDrawer();
          }

          // context.router.pushPath('/reports');
          context.router.navigate(ReportRoute());
        },
      ),

      /// DEBUG MODE
      DrawerItem(
        icon: Icons.code_outlined,
        selectedIcon: Icons.code,
        label: Constants.titleDebugMode,
        onTap: () async {},
      ),

      /// SEND LOGS
      DrawerItem(
        icon: Icons.send_to_mobile_outlined,
        selectedIcon: Icons.send_to_mobile,
        label: Constants.titleSendError,
        onTap: () async {},
      ),

      /// ABOUT US
      DrawerItem(
        icon: Icons.info_outline,
        selectedIcon: Icons.info,
        label: Constants.titleAboutUS,
        onTap: () async {},
      ),

      /// LIGHT AND DARK MODE
      DrawerItem(
        icon: themeData == lightMode
            ? Icons.light_mode_outlined
            : Icons.dark_mode_outlined,
        selectedIcon: themeData == lightMode
            ? Icons.light_mode
            : Icons.dark_mode,
        label: themeData == lightMode
            ? Constants.titleLightMode
            : Constants.titleDarkMode,
        onTap: () async {
          dashboardViewModel.toggleTheme();
        },
      ),
    ];

    return SizedBox(
      width: size.width * 0.80,
      child: SafeArea(
        bottom: false, // we only want to respect bottom inside the drawer
        child: NavigationDrawer(
          backgroundColor: colorScheme.surface,
          indicatorColor: colorScheme.primary,
          selectedIndex: selectedDrawerIndex,
          onDestinationSelected: (index) async {
            dashboardViewModel.setSelectedDrawerIndex(index);
            drawerItems[index].onTap();

            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.closeDrawer();
            }
          },

          /// HEADER
          header: SizedBox(
            width: size.width,
            child: DrawerHeader(
              decoration: BoxDecoration(color: colorScheme.surface),
              child: Row(
                spacing: 8.0.r,
                children: [
                  Icon(Icons.bar_chart, size: 36.r, color: colorScheme.primary),
                  Text(
                    'ZEUS',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: Fonts.fontMontserrat,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// LOGOUT
          footer: Padding(
            padding: const EdgeInsets.all(16.0).r,
            child: ListTile(
              leading: Icon(Icons.logout, size: 20.r, color: redColor()),
              title: Text(
                Constants.titleLogout,
                style: TextStyle(
                  fontFamily: Fonts.fontPoppins,
                  fontSize: 12.0.sp,
                  color: redColor(),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: .ellipsis,
              ),
              onTap: () async {},
            ),
          ),

          /// LIST OF DRAWER ITEMS
          children: [
            /// Dropdown
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0).r,
              padding: EdgeInsets.symmetric(horizontal: 12.0).r,
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(8.0.r),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8.0.r),
                  value: selectedProperty.isNotEmpty
                      ? selectedProperty
                      : properties[0],
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  isExpanded: true,
                  items: properties.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w300,
                          fontFamily: Fonts.fontPoppins,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      dashboardViewModel.setSelectedProperty(value);

                      if (scaffoldKey.currentState!.isDrawerOpen) {
                        scaffoldKey.currentState!.closeDrawer();
                      }
                    }
                  },
                ),
              ),
            ),

            for (final item in drawerItems)
              NavigationDrawerDestination(
                icon: Icon(item.icon, size: 20.0.r, color: colorScheme.onSurface),
                selectedIcon: Icon(
                  item.selectedIcon,
                  size: 20.0.r,
                  color: drawerItems.indexOf(item) == selectedDrawerIndex
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                ),
                label: Flexible(
                  child: MarqueeWidget(
                    child: Text(
                      item.label,
                      style: TextStyle(
                        fontFamily: Fonts.fontPoppins,
                        fontSize: 12.0.sp,
                        color: drawerItems.indexOf(item) == selectedDrawerIndex
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final VoidCallback onTap;

  DrawerItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.onTap,
  });
}

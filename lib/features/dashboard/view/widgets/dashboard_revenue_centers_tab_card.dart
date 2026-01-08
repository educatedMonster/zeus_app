import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/build_header_chart.dart';
import '../../../../shared/widgets/by_hour_view.dart';
import '../../../../shared/widgets/by_shift_view.dart';

class DashboardRevenueCentersTabCard extends StatefulWidget {
  const DashboardRevenueCentersTabCard({super.key});

  @override
  State<DashboardRevenueCentersTabCard> createState() =>
      _DashboardRevenueCentersTabCardState();
}

class _DashboardRevenueCentersTabCardState
    extends State<DashboardRevenueCentersTabCard>
    with SingleTickerProviderStateMixin {
  late ColorScheme _colorScheme;
  late Size _size;
  late TabController _tabController;
  String _selectedCenter = 'Coffee Shop';
  final List<String> _centers = ['Rooms', 'Banquet', 'Coffee Shop'];
  final List<double> _data = [1800.0, 1200.0, 2000.0, 1400.0, 3000.0];
  final List<String> _labels = ['7 AM', '8 AM', '9 AM', '10 AM', '11 AM'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    _colorScheme = context.contextColorScheme();
    _size = context.contextSize();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0).r,
      decoration: BoxDecoration(
        color: _colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.0).r,
        boxShadow: [
          BoxShadow(
            color: _colorScheme.surfaceContainer.withValues(alpha: 0.1),
            blurRadius: 10.0.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 16.0.r,
        children: [
          /// Title and download icon
          BuildHeaderChart(label: 'Revenue Centers'),

          /// Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0).r,
            decoration: BoxDecoration(
              color: _colorScheme.onSurface.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8.0).r,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCenter,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                isExpanded: true,
                items: _centers.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: dropdownTextStyle(_colorScheme)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedCenter = value);
                  }
                },
              ),
            ),
          ),

          /// Tab bar
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0.r),
              border: Border.all(
                color: _colorScheme.onSurface.withValues(alpha: 0.10),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: _colorScheme.onSurface.withValues(alpha: 1.0),
              unselectedLabelColor: _colorScheme.onSurface.withValues(
                alpha: 0.50,
              ),
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
                color: _colorScheme.onSurface.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6.0.r),
              ),
              labelStyle: tabBarTextStyle(_colorScheme),
              tabs: [
                Tab(
                  child: Text('By Shift', style: tabBarTextStyle(_colorScheme)),
                ),
                Tab(
                  child: Text(
                    'Hourly View',
                    style: tabBarTextStyle(_colorScheme),
                  ),
                ),
              ],
            ),
          ),

          /// TabBarView content
          SizedBox(
            height: 200.0.r, // Adjust based on content
            child: TabBarView(
              controller: _tabController,
              children: [
                ByShiftView(colorScheme: _colorScheme),
                ByHourView(
                  colorScheme: _colorScheme,
                  width: _size.width,
                  data: _data,
                  labels: _labels,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

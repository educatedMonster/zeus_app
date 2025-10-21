import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardRevenueCentersTabCard extends StatefulWidget {
  const DashboardRevenueCentersTabCard({super.key});

  @override
  State<DashboardRevenueCentersTabCard> createState() =>
      _DashboardRevenueCentersTabCardState();
}

class _DashboardRevenueCentersTabCardState
    extends State<DashboardRevenueCentersTabCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedCenter = 'Coffee Shop';

  final List<String> centers = ['Rooms', 'Banquet', 'Coffee Shop'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 16.0.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0.r,
        children: [
          /// Title and download icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Revenue Centers',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          /// Dropdown
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0).r,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FA),
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedCenter,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                isExpanded: true,
                items: centers.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedCenter = value);
                  }
                },
              ),
            ),
          ),

          /// Tab bar
          Container(
            height: 42.0.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.grey[600],
              indicatorSize: TabBarIndicatorSize.tab,
              // fill each tab
              indicatorPadding: EdgeInsets.zero,
              // no extra padding
              indicatorWeight: 0,
              // prevent thin default line
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              // no splash that looks like a line
              indicator: BoxDecoration(
                color: const Color(0xFFE9ECF2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              labelStyle: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'By Shift'),
                Tab(text: 'Hourly View'),
              ],
            ),
          ),

          /// TabBarView content
          SizedBox(
            height: 200.0.r, // Adjust based on content
            child: TabBarView(
              controller: _tabController,
              children: [_buildByShiftView(), _buildHourlyChart()],
            ),
          ),
        ],
      ),
    );
  }

  /// --- By Shift View ---
  Widget _buildByShiftView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.r, vertical: 4.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0.r,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Day Shift',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
              ),
              Text(
                '154,000.00',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Night Shift',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
              ),
              Text(
                '80,000.00',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// --- Hourly Bar Chart View ---
  Widget _buildHourlyChart() {
    final data = [1800.0, 1200.0, 2000.0, 1400.0, 3000.0];
    final labels = ['7 AM', '8 AM', '9 AM', '10 AM', '11 AM'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // width: data.length * 60.w,
        width: MediaQuery.of(context).size.width,
        child: BarChart(
          BarChartData(
            gridData: FlGridData(show: true, drawVerticalLine: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32.0.r,
                  getTitlesWidget: (value, meta) {
                    if (value % 1000 != 0) return const SizedBox.shrink();
                    return Text(
                      '${(value / 1000).toInt()}K',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey[700],
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= labels.length) {
                      return const SizedBox.shrink();
                    }
                    return Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey[700],
                      ),
                    );
                  },
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            barGroups: List.generate(data.length, (i) {
              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: data[i],
                    color: const Color(0xFF3B4BFF),
                    width: 20.0.r,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../shared/widgets/animated_finance_line_chart.dart';
import '../../../../../../shared/widgets/build_legend_dot.dart';
import '../../../../data/sources/remote/model/finance_line_data_model.dart';
import '../../../../data/sources/remote/model/legend_item_model.dart';

class ViewReportAccountingFinanceChartCard extends StatefulWidget {
  const ViewReportAccountingFinanceChartCard({super.key});

  @override
  State<ViewReportAccountingFinanceChartCard> createState() =>
      _ViewReportAccountingFinanceChartCardState();
}

class _ViewReportAccountingFinanceChartCardState
    extends State<ViewReportAccountingFinanceChartCard> {
  late ColorScheme _colorScheme;
  late Size _size;
  int _selectedIndex = -1;

  List<LineChartBarData> financeLineBarsData = [];
  List<FinanceLineDataModel> _orig = [];
  List<FinanceLineDataModel> _temp = [];
  List<LegendItem> legendItems = [];

  final List<FlSpot> revenueSpots1 = const [
    FlSpot(0, 2),
    FlSpot(1, 0.8),
    FlSpot(2, 1.5),
    FlSpot(3, 1.2),
    FlSpot(4, 1.4),
  ];
  final List<FlSpot> revenueSpots2 = const [
    FlSpot(0, 1.6),
    FlSpot(1, 0.7),
    FlSpot(2, 1.0),
    FlSpot(3, 0.9),
    FlSpot(4, 1.1),
  ];
  final List<FlSpot> revenueSpots3 = const [
    FlSpot(0, 1.0),
    FlSpot(1, 0.4),
    FlSpot(2, 0.9),
    FlSpot(3, 0.5),
    FlSpot(4, 0.7),
  ];

  @override
  void initState() {
    super.initState();

    legendItems = [
      LegendItem(label: 'Income', color: Colors.indigo, index: 0),
      LegendItem(label: 'Expense', color: Colors.orange, index: 1),
      LegendItem(label: 'Forecasted', color: Colors.teal, index: 2),
    ];

    _orig = [
      FinanceLineDataModel(
        financeSpots: revenueSpots1,
        color: Colors.indigo,
        barWidth: 2,
      ),
      FinanceLineDataModel(
        financeSpots: revenueSpots2,
        color: Colors.orange,
        barWidth: 2,
      ),
      FinanceLineDataModel(
        financeSpots: revenueSpots3,
        color: Colors.teal,
        barWidth: 2,
      ),
    ];

    _temp = _orig.map((item) => item.copyWith()).toList();

    _updateChartFromTemp(); // Now financeLineBarsData is ready
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size.height * 0.40,
      width: _size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 4.0.r),
      decoration: BoxDecoration(
        color: _colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: _colorScheme.surfaceContainer.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final containerHeight = constraints.maxHeight;
          final containerWidth = constraints.maxWidth;

          return Column(
            crossAxisAlignment: .start,
            children: [
              /// Title and download icon
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Actual vs Budgeted vs Forecasted',
                      style: cardTitleTextStyle(_colorScheme),
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                  ),
                  IconButton(onPressed: () async {}, icon: iconDownload()),
                ],
              ),

              /// Legend
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  spacing: 16.0.r,
                  children: legendItems.map((item) {
                    return InkWell(
                      onTap: () => _onLegendTap(item.index),
                      child: BuildLegendDot(
                        color: _selectedIndex == -1
                            ? item.color
                            : _selectedIndex == item.index
                            ? item.color
                            : Colors.grey,
                        label: item.label,
                      ),
                    );
                  }).toList(),
                ),
              ),

              Expanded(
                child: AnimatedFinanceLineChart(
                  keyAnimation: 'view-report-room-revenue-chard-card',
                  progressColor: Colors.blue,
                  containerHeight: containerHeight,
                  containerWidth: containerWidth,
                  lineBarsData: financeLineBarsData,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _colorScheme = context.contextColorScheme();
    _size = context.contextSize();
    super.didChangeDependencies();
  }

  /// When a legend item is tapped
  void _onLegendTap(int tappedIndex) {
    setState(() {
      if (_selectedIndex == tappedIndex) {
        // Deselect
        _selectedIndex = -1;
        for (int i = 0; i < _temp.length; i++) {
          _temp[i] = _orig[i]; // restore original color & width
        }
      } else {
        // Select and grey out others
        _selectedIndex = tappedIndex;
        for (int i = 0; i < _temp.length; i++) {
          final isSelected = i == tappedIndex;
          _temp[i] = _temp[i].copyWith(
            barWidth: isSelected ? 5 : 2,
            color: isSelected ? _orig[i].color : Colors.grey,
          );
        }
      }

      _updateChartFromTemp();
    });
  }

  /// Rebuild chart data from temp list
  void _updateChartFromTemp() {
    financeLineBarsData = _temp.map((e) {
      return LineChartBarData(
        isCurved: true,
        preventCurveOverShooting: true,
        color: e.color,
        barWidth: e.barWidth,
        dotData: FlDotData(show: true),
        spots: e.financeSpots,
      );
    }).toList();
  }
}

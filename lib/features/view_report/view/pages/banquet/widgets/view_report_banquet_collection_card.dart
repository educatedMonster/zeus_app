import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../shared/widgets/animated_collection_stack_bar_chart.dart';
import '../../../../../../shared/widgets/build_header_chart.dart';
import '../../../../../../shared/widgets/build_legend_dot.dart';
import '../../../../data/sources/remote/model/collection_data_model.dart';

class ViewReportBanquetCollectionCard extends StatelessWidget {
  final String parentKeyAnimation;
  final String childKeyAnimation;
  final List<CollectionBarDataModel> collectionBarDataModelList;

  const ViewReportBanquetCollectionCard({
    super.key,
    required this.parentKeyAnimation,
    required this.childKeyAnimation,
    required this.collectionBarDataModelList,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.contextColorScheme();
    double width = context.contextWidth();

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 16.0.r),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
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
        crossAxisAlignment: .start,
        spacing: 24.0.r,
        children: [
          /// Header
          BuildHeaderChart(
            label: 'Total Collection per Date',
            icon: iconDownload(),
            onIconPressed: () => debugPrint('Download pressed'),
          ),

          /// Legend
          Column(
            crossAxisAlignment: .start,
            spacing: 24.0.r,
            children: [
              /// Legend
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  spacing: 16.0.r,
                  children: List.generate(collectionBarDataModelList.length, (
                    index,
                  ) {
                    CollectionBarDataModel section =
                        collectionBarDataModelList[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.0.r),
                      child: InkWell(
                        // onTapDown: (_) => setState(() => touchedIndex = index), // TODO: You can use provider to store the index
                        // onTapUp: (_) => setState(() => touchedIndex = -1), // TODO: You can use provider to store the index
                        child: BuildLegendDot(
                          color: section.legendColor,
                          label: section.title,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              /// Chart
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: AnimatedCollectionStackBarChart(
                  keyAnimation:
                      '$parentKeyAnimation-$childKeyAnimation-dashboard_revenue_by_property_chart',
                  collectionBarDataModelList: collectionBarDataModelList,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

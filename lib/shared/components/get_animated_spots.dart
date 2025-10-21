import 'package:fl_chart/fl_chart.dart';

List<FlSpot> getAnimatedSpots(final List<FlSpot> revenueSpots, double t) {
  final int fullCount = revenueSpots.length;
  final double currentIndex = t * (fullCount - 1);
  final int lastIndex = currentIndex.floor();

  List<FlSpot> visible = [];

  for (int i = 0; i < lastIndex; i++) {
    visible.add(revenueSpots[i]);
  }

  // Interpolate between last and next point
  if (lastIndex < fullCount - 1) {
    final FlSpot start = revenueSpots[lastIndex];
    final FlSpot end = revenueSpots[lastIndex + 1];
    final double localT = currentIndex - lastIndex;

    final double interpolatedX = start.x + (end.x - start.x) * localT;
    final double interpolatedY = start.y + (end.y - start.y) * localT;

    visible.add(FlSpot(interpolatedX, interpolatedY));
  } else {
    visible.add(revenueSpots.last);
  }

  return visible;
}

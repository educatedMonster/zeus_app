String formatNumber(double value) {
  if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1).replaceAll('.0', '')}M';
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(1).replaceAll('.0', '')}K';
  } else if (value >= 100) {
    return (value / 1).toStringAsFixed(0);
  } else if (value >= 10) {
    return (value / 1).toStringAsFixed(0);
  } else if (value >= 1) {
    return (value / 1).toStringAsFixed(1);
  } else if (value == 0) {
    return value.toStringAsFixed(0);
  } else {
    return value.toStringAsFixed(1);
  }
}

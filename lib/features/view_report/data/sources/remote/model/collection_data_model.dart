import 'dart:ui' show Color;

class CollectionBarDataModel {
  final String title;
  final Color legendColor;
  final String label;
  final int order;
  final double a;
  final double b;
  final double c;

  CollectionBarDataModel({
    required this.title,
    required this.legendColor,
    required this.label,
    required this.order,
    required this.a,
    required this.b,
    required this.c,
  });

  CollectionBarDataModel copyWith({
    String? title,
    Color? legendColor,
    String? label,
    int? order,
    double? a,
    double? b,
    double? c,
  }) => CollectionBarDataModel(
    title: title ?? this.title,
    legendColor: legendColor ?? this.legendColor,
    label: label ?? this.label,
    order: order ?? this.order,
    a: b ?? this.a,
    b: b ?? this.b,
    c: c ?? this.c,
  );
}

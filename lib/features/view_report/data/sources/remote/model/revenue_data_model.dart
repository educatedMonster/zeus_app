class RevenueDataModel {
  final String label;
  final int order;
  final double a;
  final double b;
  final double c;

  RevenueDataModel({
    required this.label,
    required this.order,
    required this.a,
    required this.b,
    required this.c,
  });

  RevenueDataModel copyWith({
    String? label,
    int? order,
    double? a,
    double? b,
    double? c,
  }) => RevenueDataModel(
    label: label ?? this.label,
    order: order ?? this.order,
    a: b ?? this.a,
    b: b ?? this.b,
    c: c ?? this.c,
  );
}

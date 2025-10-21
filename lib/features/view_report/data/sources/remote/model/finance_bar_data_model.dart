class FinanceBarDataModel {
  final String label;
  final int order;
  final double a;
  final double b;

  FinanceBarDataModel({
    required this.label,
    required this.order,
    required this.a,
    required this.b,
  });

  FinanceBarDataModel copyWith({
    String? label,
    int? order,
    double? a,
    double? b,
  }) => FinanceBarDataModel(
    label: label ?? this.label,
    order: order ?? this.order,
    a: b ?? this.a,
    b: b ?? this.b,
  );
}

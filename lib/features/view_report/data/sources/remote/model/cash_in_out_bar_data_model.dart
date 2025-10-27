class CashInOutBarDataModel {
  final String label;
  final int order;
  final double a;
  final double b;

  CashInOutBarDataModel({
    required this.label,
    required this.order,
    required this.a,
    required this.b,
  });

  CashInOutBarDataModel copyWith({
    String? label,
    int? order,
    double? a,
    double? b,
  }) => CashInOutBarDataModel(
    label: label ?? this.label,
    order: order ?? this.order,
    a: b ?? this.a,
    b: b ?? this.b,
  );
}

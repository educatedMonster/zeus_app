import 'package:flutter/material.dart';

class LegendItem {
  final String label;
  final Color color;
  final int index;

  LegendItem({required this.label, required this.color, required this.index});

  LegendItem copyWith({String? label, Color? color, int? index}) => LegendItem(
    label: label ?? this.label,
    color: color ?? this.color,
    index: index ?? this.index,
  );
}

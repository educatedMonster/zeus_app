import '../../local/entity/sample_entity.dart';

class SampleModel {
  final String id;
  final String title;
  final String description;
  final String color;

  SampleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
  });

  factory SampleModel.fromJson(Map<String, dynamic> json) => SampleModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {"id": id, "title": title};
}

extension SampleModelEntityMapper on SampleModel {
  SampleEntity toSampleModelEntity() {
    return SampleEntity(
      id: id,
      title: title,
      description: description,
      color: color,
    );
  }
}

import '../../../../../sample/data/sources/remote/model/sample_model.dart';

class SampleEntity {
  final String id;
  final String title;
  final String description;
  final String color;

  SampleEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
  });

  // Convert Entity → Map (for insert)
  // Method to convert a 'SampleModel' to a map
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'color': color,
  };

  // Convert Map → Entity (for get)
  // Convert a SampleModel into a Map. The keys must correspond to the names of the
  // columns in the database.
  factory SampleEntity.fromMap(Map<String, dynamic> map) => SampleEntity(
    id: map['id'],
    title: map['title'],
    description: map['description'],
    color: map['color'],
  );
}

extension SampleModelMapper on SampleEntity {
  SampleModel toSampleEntity() {
    return SampleModel(
      id: id,
      title: title,
      description: description,
      color: color,
    );
  }
}

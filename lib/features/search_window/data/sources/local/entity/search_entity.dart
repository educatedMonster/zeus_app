import '../../../../../search_window/data/sources/remote/model/search_model.dart';

class SearchEntity {
  final String id;
  final String title;
  final String description;
  final String color;

  SearchEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
  });

  // Convert Entity → Map (for insert)
  // Method to convert a 'SearchWindowModel' to a map
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'color': color,
  };

  // Convert Map → Entity (for get)
  // Convert a SearchModel into a Map. The keys must correspond to the names of the
  // columns in the database.
  factory SearchEntity.fromMap(Map<String, dynamic> map) =>
      SearchEntity(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        color: map['color'],
      );
}

extension SearchModelMapper on SearchEntity {
  SearchModel toSearchEntity() {
    return SearchModel(
      id: id,
      title: title,
      description: description,
      color: color,
    );
  }
}

import '../../local/entity/search_entity.dart';

class SearchModel {
  final String id;
  final String title;
  final String description;
  final String color;

  SearchModel({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      SearchModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {"id": id, "title": title};
}

extension SearchModelEntityMapper on SearchModel {
  SearchEntity toSearchEntity() {
    return SearchEntity(
      id: id,
      title: title,
      description: description,
      color: color,
    );
  }
}

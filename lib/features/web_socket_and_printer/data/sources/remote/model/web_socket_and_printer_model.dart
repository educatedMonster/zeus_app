import '../../local/entity/web_socket_and_printer_entity.dart';

class WebSocketAndPrinterModel {
  final String id;
  final String title;
  final String description;
  final String color;

  WebSocketAndPrinterModel({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
  });

  factory WebSocketAndPrinterModel.fromJson(Map<String, dynamic> json) => WebSocketAndPrinterModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

extension WebSocketAndPrinterModelEntityMapper on WebSocketAndPrinterModel {
  WebSocketAndPrinterEntity toWebSocketAndPrinterEntity() {
    return WebSocketAndPrinterEntity(
      id: id,
      title: title,
      description: description,
      color: color,
    );
  }
}

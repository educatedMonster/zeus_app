import 'dart:ui';

import '../../../../../web_socket_and_printer/data/sources/remote/model/web_socket_and_printer_model.dart';

class WebSocketAndPrinterEntity {
  final String id;
  final String title;
  final String description;
  final String color;

  WebSocketAndPrinterEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
  });

  // Convert Entity → Map (for insert)
  // Method to convert a 'WebSocketAndPrinterModel' to a map
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'color': color,
  };

  // Convert Map → Entity (for get)
  // Convert a WebSocketAndPrinterModel into a Map. The keys must correspond to the names of the
  // columns in the database.
  factory WebSocketAndPrinterEntity.fromMap(Map<String, dynamic> map) => WebSocketAndPrinterEntity(
    id: map['id'],
    title: map['title'],
    description: map['description'],
    color: map['color'],
  );
}

extension WebSocketAndPrinterModelMapper on WebSocketAndPrinterEntity {
  WebSocketAndPrinterModel toWebSocketAndPrinterEntity() {
    return WebSocketAndPrinterModel(
      id: id,
      title: title,
      description: description,
      color: color,
    );
  }
}

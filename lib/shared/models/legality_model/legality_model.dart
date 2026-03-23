import 'dart:convert';

class LegalityModel {
  final String id;
  final String type;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  LegalityModel({
    required this.id,
    required this.type,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LegalityModel.fromRawJson(String str) =>
      LegalityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LegalityModel.fromJson(Map<String, dynamic> json) => LegalityModel(
    id: json["_id"],
    type: json["type"],
    content: json["content"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "content": content,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

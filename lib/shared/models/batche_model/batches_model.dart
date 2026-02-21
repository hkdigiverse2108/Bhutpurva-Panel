import 'dart:convert';

class BatchesModel {
  String id;
  String name;
  List<dynamic> monitorIds;
  bool isActive;
  DateTime createdAt;

  BatchesModel({
    required this.id,
    required this.name,
    required this.monitorIds,
    required this.isActive,
    required this.createdAt,
  });

  factory BatchesModel.fromRawJson(String str) =>
      BatchesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BatchesModel.fromJson(Map<String, dynamic> json) => BatchesModel(
    id: json["_id"],
    name: json["name"],
    monitorIds: List<dynamic>.from(json["monitorIds"].map((x) => x)),
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "monitorIds": List<dynamic>.from(monitorIds.map((x) => x)),
    "isActive": isActive,
    "createdAt": createdAt.toIso8601String(),
  };
}

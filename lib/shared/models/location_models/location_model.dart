import 'dart:convert';

class LocationModel {
  final String id;
  final String name;
  final String type;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LocationModel.fromRawJson(String str) =>
      LocationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    id: json["_id"],
    name: json["name"],
    type: json["type"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "type": type,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class LocationDropdownModel {
  final String id;
  final String name;
  final String? type;

  LocationDropdownModel({required this.id, required this.name, this.type});

  factory LocationDropdownModel.fromRawJson(String str) =>
      LocationDropdownModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationDropdownModel.fromJson(Map<String, dynamic> json) =>
      LocationDropdownModel(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "type": type};
}

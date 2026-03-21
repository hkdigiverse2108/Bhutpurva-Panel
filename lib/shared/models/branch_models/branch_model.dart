import 'dart:convert';

class BranchModel {
  final String name;
  final bool isActive;
  final bool isDeleted;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  BranchModel({
    required this.name,
    required this.isActive,
    required this.isDeleted,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BranchModel.fromRawJson(String str) =>
      BranchModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    name: json["name"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

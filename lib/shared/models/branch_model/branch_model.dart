import 'dart:convert';

class BranchModel {
  final String id;
  final String name;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  BranchModel({
    required this.id,
    required this.name,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BranchModel.allFromRawJson(String str) =>
      BranchModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    isActive: json["isActive"] ?? false,
    isDeleted: json["isDeleted"] ?? false,
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now(),
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class BranchDropdownModel {
  final String id;
  final String name;

  BranchDropdownModel({required this.id, required this.name});

  factory BranchDropdownModel.fromRawJson(String str) =>
      BranchDropdownModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BranchDropdownModel.fromJson(Map<String, dynamic> json) =>
      BranchDropdownModel(id: json["_id"] ?? "", name: json["name"] ?? "");

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

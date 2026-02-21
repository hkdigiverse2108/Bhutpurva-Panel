import 'dart:convert';

class GroupModel {
  String id;
  String name;
  List<dynamic> leaders;
  bool isActive;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;

  GroupModel({
    required this.id,
    required this.name,
    required this.leaders,
    required this.isDeleted,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroupModel.fromRawJson(String str) =>
      GroupModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    // The API might return `leaderIds` instead of `leaders`. This safely falls back to empty list if both are null.
    leaders: List<dynamic>.from(
      (json["leaders"] ?? json["leaderIds"] ?? []).map((x) => x),
    ),
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? false,
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
    "leaders": List<dynamic>.from(leaders.map((x) => x)),
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

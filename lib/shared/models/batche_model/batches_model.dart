import 'dart:convert';

class BatchesModel {
  String id;
  String name;
  GroupId? groupId;
  List<dynamic> monitorIds;
  bool isActive;
  DateTime createdAt;

  BatchesModel({
    required this.id,
    required this.name,
    this.groupId,
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
    groupId: json["groupId"] != null ? GroupId.fromJson(json["groupId"]) : null,
    monitorIds: List<dynamic>.from(json["monitorIds"].map((x) => x)),
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "groupId": groupId?.toJson(),
    "monitorIds": List<dynamic>.from(monitorIds.map((x) => x)),
    "isActive": isActive,
    "createdAt": createdAt.toIso8601String(),
  };
}

class GroupId {
  String id;
  String name;

  GroupId({required this.id, required this.name});

  factory GroupId.fromJson(dynamic json) {
    if (json is String) {
      return GroupId(id: json, name: "");
    }
    return GroupId(id: json["_id"] ?? "", name: json["name"] ?? "");
  }

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

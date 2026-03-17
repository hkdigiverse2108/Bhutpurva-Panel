import 'dart:convert';

class LifeLightModel {
  String id;
  UserId userId;
  String lifeLight;
  String status;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;

  LifeLightModel({
    required this.id,
    required this.userId,
    required this.lifeLight,
    required this.status,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LifeLightModel.fromRawJson(String str) =>
      LifeLightModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LifeLightModel.fromJson(Map<String, dynamic> json) => LifeLightModel(
    id: json["_id"],
    userId: UserId.fromJson(json["userId"]),
    lifeLight: json["lifeLight"],
    status: json["status"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId.toJson(),
    "lifeLight": lifeLight,
    "status": status,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class UserId {
  String id;
  String email;
  String name;

  UserId({required this.id, required this.email, required this.name});

  factory UserId.fromRawJson(String str) => UserId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserId.fromJson(Map<String, dynamic> json) =>
      UserId(id: json["_id"], email: json["email"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "email": email, "name": name};
}

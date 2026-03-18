import 'dart:convert';

class AnubhutiModel {
  String id;
  UserId userId;
  String anubhuti;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;

  AnubhutiModel({
    required this.id,
    required this.userId,
    required this.anubhuti,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AnubhutiModel.fromRawJson(String str) =>
      AnubhutiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnubhutiModel.fromJson(Map<String, dynamic> json) => AnubhutiModel(
    id: json["_id"],
    userId: UserId.fromJson(json["userId"]),
    anubhuti: json["anubhuti"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId.toJson(),
    "anubhuti": anubhuti,
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

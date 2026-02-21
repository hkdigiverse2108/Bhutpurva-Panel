import 'dart:convert';

class LoginRes {
  AdminModel user;
  String token;

  LoginRes({required this.user, required this.token});

  factory LoginRes.fromRawJson(String str) =>
      LoginRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRes.fromJson(Map<String, dynamic> json) =>
      LoginRes(user: AdminModel.fromJson(json["user"]), token: json["token"]);

  Map<String, dynamic> toJson() => {"user": user.toJson(), "token": token};
}

class AdminModel {
  String id;
  String email;
  String name;
  String gender;
  String role;
  List<dynamic> addressIds;
  List<dynamic> professions;
  List<dynamic> educations;
  List<dynamic> talents;
  List<dynamic> awards;
  bool isDeleted;
  bool isVerified;
  DateTime createdAt;
  DateTime updatedAt;

  AdminModel({
    required this.id,
    required this.email,
    required this.name,
    required this.gender,
    required this.role,
    required this.addressIds,
    required this.professions,
    required this.educations,
    required this.talents,
    required this.awards,
    required this.isDeleted,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdminModel.fromRawJson(String str) =>
      AdminModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    gender: json["gender"],
    role: json["role"],
    addressIds: List<dynamic>.from(json["addressIds"].map((x) => x)),
    professions: List<dynamic>.from(json["professions"].map((x) => x)),
    educations: List<dynamic>.from(json["educations"].map((x) => x)),
    talents: List<dynamic>.from(json["talents"].map((x) => x)),
    awards: List<dynamic>.from(json["awards"].map((x) => x)),
    isDeleted: json["isDeleted"],
    isVerified: json["isVerified"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "name": name,
    "gender": gender,
    "role": role,
    "addressIds": List<dynamic>.from(addressIds.map((x) => x)),
    "professions": List<dynamic>.from(professions.map((x) => x)),
    "educations": List<dynamic>.from(educations.map((x) => x)),
    "talents": List<dynamic>.from(talents.map((x) => x)),
    "awards": List<dynamic>.from(awards.map((x) => x)),
    "isDeleted": isDeleted,
    "isVerified": isVerified,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

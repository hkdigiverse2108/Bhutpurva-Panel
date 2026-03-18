import 'dart:convert';

class FeedbackModel {
  final String id;
  final UserId userId;
  final String feedback;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.feedback,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FeedbackModel.fromRawJson(String str) =>
      FeedbackModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
    id: json["_id"],
    userId: UserId.fromJson(json["userId"]),
    feedback: json["feedback"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId.toJson(),
    "feedback": feedback,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class UserId {
  final String id;
  final String email;
  final String name;

  UserId({required this.id, required this.email, required this.name});

  factory UserId.fromRawJson(String str) => UserId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserId.fromJson(Map<String, dynamic> json) =>
      UserId(id: json["_id"], email: json["email"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "email": email, "name": name};
}

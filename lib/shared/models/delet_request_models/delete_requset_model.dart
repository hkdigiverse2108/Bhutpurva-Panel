import 'dart:convert';

class DeleteRequestListModel {
  final List<DeleteRequestModel> deleteRequests;
  final State? state;
  final int totalData;

  DeleteRequestListModel({
    required this.deleteRequests,
    this.state,
    required this.totalData,
  });

  factory DeleteRequestListModel.fromRawJson(String str) =>
      DeleteRequestListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteRequestListModel.fromJson(Map<String, dynamic> json) =>
      DeleteRequestListModel(
        deleteRequests: List<DeleteRequestModel>.from(
          (json["deleteRequests"] as List).map((x) => DeleteRequestModel.fromJson(x)),
        ),
        state: json["state"] != null ? State.fromJson(json["state"]) : null,
        totalData: json["totalData"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "deleteRequests": List<dynamic>.from(deleteRequests.map((x) => x.toJson())),
    "state": state?.toJson(),
    "totalData": totalData,
  };
}

class DeleteRequestModel {
  final String id;
  final UserId userId;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DeleteRequestModel({
    required this.id,
    required this.userId,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory DeleteRequestModel.fromRawJson(String str) =>
      DeleteRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteRequestModel.fromJson(Map<String, dynamic> json) =>
      DeleteRequestModel(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        status: json["status"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId.toJson(),
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
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

class State {
  final int page;
  final dynamic totalPages;

  State({required this.page, required this.totalPages});

  factory State.fromRawJson(String str) => State.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory State.fromJson(Map<String, dynamic> json) =>
      State(page: json["page"], totalPages: json["totalPages"]);

  Map<String, dynamic> toJson() => {"page": page, "totalPages": totalPages};
}

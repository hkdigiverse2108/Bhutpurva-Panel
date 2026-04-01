import 'dart:convert';

class MonitorModel {
  final String id; // monitor record _id
  final MonitorUser userId; // populated user
  final String status;
  final List<dynamic> devoteeIds;

  MonitorModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.devoteeIds,
  });

  factory MonitorModel.fromRawJson(String str) =>
      MonitorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MonitorModel.fromJson(Map<String, dynamic> json) => MonitorModel(
    id: json["_id"] ?? "",
    userId: MonitorUser.fromJson(json["userId"] ?? {}),
    status: json["status"] ?? "",
    devoteeIds: List<dynamic>.from(json["devoteeIds"] ?? []),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId.toJson(),
    "status": status,
    "devoteeIds": devoteeIds,
  };
}

class MonitorUser {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;

  MonitorUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory MonitorUser.fromJson(Map<String, dynamic> json) => MonitorUser(
    id: json["_id"] ?? json["id"] ?? "",
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    phoneNumber: json["phoneNumber"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
  };
}

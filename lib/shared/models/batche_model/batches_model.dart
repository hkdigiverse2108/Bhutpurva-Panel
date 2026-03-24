import 'dart:convert';

class BatchesModel {
  final String id;
  final String name;
  final GroupId? groupId;
  final List<dynamic> monitorIds;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Student> students;
  final int studentCount;

  BatchesModel({
    required this.id,
    required this.name,
    this.groupId,
    required this.monitorIds,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.students,
    required this.studentCount,
  });

  factory BatchesModel.fromRawJson(String str) =>
      BatchesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BatchesModel.fromJson(Map<String, dynamic> json) => BatchesModel(
    id: json["_id"],
    name: json["name"],
    groupId: json["groupId"] == null ? null : GroupId.fromJson(json["groupId"]),
    monitorIds: List<dynamic>.from(json["monitorIds"].map((x) => x)),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    students: List<Student>.from(
      json["students"].map((x) => Student.fromJson(x)),
    ),
    studentCount: json["studentCount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "groupId": groupId?.toJson(),
    "monitorIds": List<dynamic>.from(monitorIds.map((x) => x)),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "students": List<dynamic>.from(students.map((x) => x.toJson())),
    "studentCount": studentCount,
  };
}

class GroupId {
  final String id;
  final String name;
  final List<String> leaderIds;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  GroupId({
    required this.id,
    required this.name,
    required this.leaderIds,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroupId.fromRawJson(String str) => GroupId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupId.fromJson(Map<String, dynamic> json) => GroupId(
    id: json["_id"],
    name: json["name"],
    leaderIds: List<String>.from(json["leaderIds"].map((x) => x)),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "leaderIds": List<dynamic>.from(leaderIds.map((x) => x)),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Student {
  final String id;
  final String email;
  final String name;
  final String surname;
  final String phoneNumber;
  final String currentCity;
  final bool isVerified;

  Student({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.currentCity,
    required this.isVerified,
  });

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    surname: json["surname"],
    phoneNumber: json["phoneNumber"],
    currentCity: json["currentCity"],
    isVerified: json["isVerified"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "name": name,
    "surname": surname,
    "phoneNumber": phoneNumber,
    "currentCity": currentCity,
    "isVerified": isVerified,
  };
}

class BatchDropdownModel {
  final String id;
  final String name;

  BatchDropdownModel({required this.id, required this.name});

  factory BatchDropdownModel.fromJson(Map<String, dynamic> json) =>
      BatchDropdownModel(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

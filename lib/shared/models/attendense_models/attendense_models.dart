import 'dart:convert';

class AttendanceModel {
  final String id;
  final Id programId;
  final Id batchId;
  final List<dynamic> students;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  AttendanceModel({
    required this.id,
    required this.programId,
    required this.batchId,
    required this.students,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttendanceModel.fromRawJson(String str) =>
      AttendanceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        id: json["_id"],
        programId: Id.fromJson(json["programId"]),
        batchId: Id.fromJson(json["batchId"]),
        students: List<dynamic>.from(json["students"].map((x) => x)),
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "programId": programId.toJson(),
    "batchId": batchId.toJson(),
    "students": List<dynamic>.from(students.map((x) => x)),
    "date": date.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Id {
  final String id;
  final String name;

  Id({required this.id, required this.name});

  factory Id.fromRawJson(String str) => Id.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Id.fromJson(Map<String, dynamic> json) =>
      Id(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

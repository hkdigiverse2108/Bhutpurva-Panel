import 'dart:convert';

class AttendanceModel {
  final String id;
  final Id programId;
  final Id batchId;
  final List<Student> students;
  final DateTime date;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  AttendanceModel({
    required this.id,
    required this.programId,
    required this.batchId,
    required this.students,
    required this.date,
    required this.isDeleted,
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
        students: List<Student>.from(
          json["students"].map((x) => Student.fromJson(x)),
        ),
        date: DateTime.parse(json["date"]),
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "programId": programId.toJson(),
    "batchId": batchId.toJson(),
    "students": List<dynamic>.from(students.map((x) => x.toJson())),
    "date": date.toIso8601String(),
    "isDeleted": isDeleted,
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

class Student {
  final String studentId;
  final bool isPresent;

  Student({required this.studentId, required this.isPresent});

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) =>
      Student(studentId: json["studentId"], isPresent: json["isPresent"]);

  Map<String, dynamic> toJson() => {
    "studentId": studentId,
    "isPresent": isPresent,
  };
}

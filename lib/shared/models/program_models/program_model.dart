import 'dart:convert';

class ProgramModel {
  final List<Program> programs;
  final State state;
  final int totalData;

  ProgramModel({
    required this.programs,
    required this.state,
    required this.totalData,
  });

  factory ProgramModel.fromRawJson(String str) =>
      ProgramModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProgramModel.fromJson(Map<String, dynamic> json) => ProgramModel(
    programs: List<Program>.from(
      json["programs"].map((x) => Program.fromJson(x)),
    ),
    state: State.fromJson(json["state"]),
    totalData: json["totalData"],
  );

  Map<String, dynamic> toJson() => {
    "programs": List<dynamic>.from(programs.map((x) => x.toJson())),
    "state": state.toJson(),
    "totalData": totalData,
  };
}

class Program {
  final String id;
  final String name;
  final BatchId batchId;
  final String description;
  final DateTime date;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  Program({
    required this.id,
    required this.name,
    required this.batchId,
    required this.description,
    required this.date,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Program.fromRawJson(String str) => Program.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Program.fromJson(Map<String, dynamic> json) => Program(
    id: json["_id"],
    name: json["name"],
    batchId: BatchId.fromJson(json["batchId"]),
    description: json["description"],
    date: DateTime.parse(json["date"]),
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "batchId": batchId.toJson(),
    "description": description,
    "date": date.toIso8601String(),
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class BatchId {
  final String id;
  final String name;
  final bool isActive;

  BatchId({required this.id, required this.name, required this.isActive});

  factory BatchId.fromRawJson(String str) => BatchId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BatchId.fromJson(Map<String, dynamic> json) =>
      BatchId(id: json["_id"], name: json["name"], isActive: json["isActive"]);

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "isActive": isActive,
  };
}

class State {
  final int page;
  final int limit;
  final int totalPages;

  State({required this.page, required this.limit, required this.totalPages});

  factory State.fromRawJson(String str) => State.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory State.fromJson(Map<String, dynamic> json) => State(
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
}

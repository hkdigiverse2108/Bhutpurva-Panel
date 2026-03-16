import 'dart:convert';

class GroupModel {
  final String id;
  final String name;
  final List<LeaderId>? leaderIds;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<GroupModel>? batches;
  final List<dynamic>? monitorIds;
  final String? groupId;

  GroupModel({
    required this.id,
    required this.name,
    this.leaderIds,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.batches,
    this.monitorIds,
    this.groupId,
  });

  factory GroupModel.fromRawJson(String str) =>
      GroupModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    id: json["_id"],
    name: json["name"],
    leaderIds: json["leaderIds"] == null
        ? []
        : List<LeaderId>.from(
            json["leaderIds"]!.map((x) => LeaderId.fromJson(x)),
          ),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    batches: json["batches"] == null
        ? []
        : List<GroupModel>.from(
            json["batches"]!.map((x) => GroupModel.fromJson(x)),
          ),
    monitorIds: json["monitorIds"] == null
        ? []
        : List<dynamic>.from(json["monitorIds"]!.map((x) => x)),
    groupId: json["groupId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "leaderIds": leaderIds == null
        ? []
        : List<dynamic>.from(leaderIds!.map((x) => x.toJson())),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "batches": batches == null
        ? []
        : List<dynamic>.from(batches!.map((x) => x.toJson())),
    "monitorIds": monitorIds == null
        ? []
        : List<dynamic>.from(monitorIds!.map((x) => x)),
    "groupId": groupId,
  };
}

class LeaderId {
  final String id;
  final String? name;
  final String? fatherName;
  final String? surname;
  final String? phoneNumber;
  final String? whatsappNumber;

  LeaderId({
    required this.id,
    this.name,
    this.fatherName,
    this.surname,
    this.phoneNumber,
    this.whatsappNumber,
  });

  factory LeaderId.fromRawJson(String str) =>
      LeaderId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaderId.fromJson(Map<String, dynamic> json) => LeaderId(
    id: json["_id"],
    name: json["name"],
    fatherName: json["fatherName"],
    surname: json["surname"],
    phoneNumber: json["phoneNumber"],
    whatsappNumber: json["whatsappNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "fatherName": fatherName,
    "surname": surname,
    "phoneNumber": phoneNumber,
    "whatsappNumber": whatsappNumber,
  };
}

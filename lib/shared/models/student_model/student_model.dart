import 'dart:convert';

class StudentModel {
  final String id;
  final String email;
  final String name;
  final String fatherName;
  final String surname;
  final String phoneNumber;
  final String whatsappNumber;
  final String gender;
  final String hrNo;
  final String role;
  final String currentCity;
  final List<AddressId> addressIds;
  final String occupation;
  final List<String> professions;
  final List<dynamic> educations;
  final String maritalStatus;
  final String bloodGroup;
  final Class12Class class10;
  final Class12Class class12;
  final StudyId? studyId;
  final String? skill;
  final List<String> talents;
  final List<String> awards;
  final bool isDeleted;
  final String otp;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? image;

  StudentModel({
    required this.id,
    required this.email,
    required this.name,
    required this.fatherName,
    required this.surname,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.gender,
    required this.hrNo,
    required this.role,
    required this.currentCity,
    required this.addressIds,
    required this.occupation,
    required this.professions,
    required this.educations,
    required this.maritalStatus,
    required this.bloodGroup,
    required this.class10,
    required this.class12,
    required this.studyId,
    this.skill,
    required this.talents,
    required this.awards,
    required this.isDeleted,
    required this.otp,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });

  factory StudentModel.fromRawJson(String str) =>
      StudentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    id: json["_id"] ?? "",
    email: json["email"] ?? "",
    name: json["name"] ?? "",
    fatherName: json["fatherName"] ?? "",
    surname: json["surname"] ?? "",
    phoneNumber: json["phoneNumber"] ?? "",
    whatsappNumber: json["whatsappNumber"] ?? "",
    gender: json["gender"] ?? "",
    hrNo: json["hrNo"] ?? "",
    role: json["role"] ?? "",
    currentCity: json["currentCity"] ?? "",
    addressIds: List<AddressId>.from(
      (json["addressIds"] as List? ?? []).map((x) => AddressId.fromJson(x)),
    ),
    occupation: json["occupation"] ?? "",
    professions: List<String>.from(
      (json["professions"] as List? ?? []).map((x) => x as String),
    ),
    educations: List<dynamic>.from(
      (json["educations"] as List? ?? []).map((x) => x),
    ),
    maritalStatus: json["maritalStatus"] ?? "",
    bloodGroup: json["bloodGroup"] ?? "",
    class10: Class12Class.fromJson(json["class10"] ?? {}),
    class12: Class12Class.fromJson(json["class12"] ?? {}),
    studyId: json["studyId"] == null ? null : StudyId.fromJson(json["studyId"]),
    skill: json["skill"],
    talents: List<String>.from(
      (json["talents"] as List? ?? []).map((x) => x as String),
    ),
    awards: List<String>.from(
      (json["awards"] as List? ?? []).map((x) => x as String),
    ),
    isDeleted: json["isDeleted"] ?? false,
    otp: json["otp"] ?? "",
    isVerified: json["isVerified"] ?? false,
    createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "name": name,
    "fatherName": fatherName,
    "surname": surname,
    "phoneNumber": phoneNumber,
    "whatsappNumber": whatsappNumber,
    "gender": gender,
    "hrNo": hrNo,
    "role": role,
    "currentCity": currentCity,
    "addressIds": List<dynamic>.from(addressIds.map((x) => x.toJson())),
    "occupation": occupation,
    "professions": List<dynamic>.from(professions.map((x) => x)),
    "educations": List<dynamic>.from(educations.map((x) => x)),
    "maritalStatus": maritalStatus,
    "bloodGroup": bloodGroup,
    "class10": class10.toJson(),
    "class12": class12.toJson(),
    "studyId": studyId?.toJson(),
    "skill": skill,
    "talents": List<dynamic>.from(talents.map((x) => x)),
    "awards": List<dynamic>.from(awards.map((x) => x)),
    "isDeleted": isDeleted,
    "otp": otp,
    "isVerified": isVerified,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "image": image,
  };
}

class AddressId {
  final String id;
  final String address;
  final String type;
  final String city;
  final String district;
  final String state;
  final String country;
  final String pincode;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddressId({
    required this.id,
    required this.address,
    required this.type,
    required this.city,
    required this.district,
    required this.state,
    required this.country,
    required this.pincode,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddressId.fromRawJson(String str) =>
      AddressId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressId.fromJson(Map<String, dynamic> json) => AddressId(
    id: json["_id"] ?? "",
    address: json["address"] ?? "",
    type: json["type"] ?? "",
    city: json["city"] ?? "",
    district: json["district"] ?? "",
    state: json["state"] ?? "",
    country: json["country"] ?? "",
    pincode: json["pincode"] ?? "",
    isDeleted: json["isDeleted"] ?? false,
    createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "address": address,
    "type": type,
    "city": city,
    "district": district,
    "state": state,
    "country": country,
    "pincode": pincode,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Class12Class {
  final String class1Class;
  final bool isStudded;
  final String? branch;
  final String? passingYear;
  final String? medium;
  final bool hostel;
  final String id;

  Class12Class({
    required this.class1Class,
    required this.isStudded,
    this.branch,
    this.passingYear,
    this.medium,
    required this.hostel,
    required this.id,
  });

  factory Class12Class.fromRawJson(String str) =>
      Class12Class.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Class12Class.fromJson(Map<String, dynamic> json) => Class12Class(
    class1Class: json["class"] ?? "",
    isStudded: json["isStudded"] ?? false,
    branch: json["branch"],
    passingYear: json["passingYear"],
    medium: json["medium"],
    hostel: json["hostel"] ?? false,
    id: json["_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "class": class1Class,
    "isStudded": isStudded,
    "branch": branch,
    "passingYear": passingYear,
    "medium": medium,
    "hostel": hostel,
    "_id": id,
  };
}

class StudyId {
  final String id;
  final Classes classes;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudyId({
    required this.id,
    required this.classes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudyId.fromRawJson(String str) => StudyId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudyId.fromJson(Map<String, dynamic> json) => StudyId(
    id: json["_id"] ?? "",
    classes: Classes.fromJson(json["classes"] ?? {}),
    createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "classes": classes.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Classes {
  final Class1Class class1;
  final Class1Class class10;

  Classes({required this.class1, required this.class10});

  factory Classes.fromRawJson(String str) => Classes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
    class1: Class1Class.fromJson(json["class1"] ?? {}),
    class10: Class1Class.fromJson(json["class10"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "class1": class1.toJson(),
    "class10": class10.toJson(),
  };
}

class Class1Class {
  final bool isStudied;
  final String branch;

  Class1Class({required this.isStudied, required this.branch});

  factory Class1Class.fromRawJson(String str) =>
      Class1Class.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Class1Class.fromJson(Map<String, dynamic> json) => Class1Class(
    isStudied: json["isStudied"] ?? false,
    branch: json["branch"] ?? "",
  );

  Map<String, dynamic> toJson() => {"isStudied": isStudied, "branch": branch};
}

import 'dart:convert';

class UserModel {
  String id;
  String email;
  String name;
  String fatherName;
  String surname;
  String phoneNumber;
  String whatsappNumber;
  String gender;
  String hrNo;
  String role;
  String currentCity;
  List<AddressId> addressIds;
  String occupation;
  List<String> professions;
  List<dynamic> educations;
  String maritalStatus;
  String bloodGroup;
  Class12Class class10;
  Class12Class class12;
  StudyId? studyId;
  String? skill;
  List<String> talents;
  List<String> awards;
  bool isDeleted;
  String otp;
  bool isVerified;
  DateTime createdAt;
  DateTime updatedAt;
  String? image;
  String? birthDate;

  UserModel({
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
    this.birthDate,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"] ?? "",
    email: json["email"] ?? "",
    name: json["name"] ?? "",
    fatherName: json["fatherName"] ?? "",
    surname: json["surname"] ?? "",
    phoneNumber: json["phoneNumber"] ?? "",
    whatsappNumber: json["whatsappNumber"] ?? "",
    gender: json["gender"] ?? "male",
    hrNo: json["hrNo"] ?? "",
    role: json["role"] ?? "user",
    currentCity: json["currentCity"] ?? "",
    addressIds: json["addressIds"] != null
        ? List<AddressId>.from(
            json["addressIds"].map((x) => AddressId.fromJson(x)),
          )
        : [],
    occupation: json["occupation"] ?? "",
    professions: json["professions"] != null
        ? List<String>.from(json["professions"].map((x) => x))
        : [],
    educations: json["educations"] != null
        ? List<dynamic>.from(json["educations"].map((x) => x))
        : [],
    maritalStatus: json["maritalStatus"] ?? "",
    bloodGroup: json["bloodGroup"] ?? "",
    class10: Class12Class.fromJson(json["class10"] ?? {}),
    class12: Class12Class.fromJson(json["class12"] ?? {}),
    studyId: json["studyId"] == null ? null : StudyId.fromJson(json["studyId"]),
    skill: json["skill"],
    talents: json["talents"] == null
        ? []
        : List<String>.from(json["talents"].map((x) => x)),
    awards: json["awards"] == null
        ? []
        : List<String>.from(json["awards"].map((x) => x)),
    isDeleted: json["isDeleted"] ?? false,
    otp: json["otp"] ?? "",
    isVerified: json["isVerified"] ?? false,
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now(),
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : DateTime.now(),
    image: json["image"],
    birthDate: json["birthDate"],
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
    "birthDate": birthDate,
  };
}

class AddressId {
  String id;
  String address;
  String type;
  String city;
  String district;
  String state;
  String country;
  String pincode;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;

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
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now(),
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : DateTime.now(),
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
  String class1Class;
  bool isStudded;
  String? branch;
  String? passingYear;
  String? medium;
  bool hostel;
  String id;

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
  String id;
  Classes classes;
  DateTime createdAt;
  DateTime updatedAt;

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
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now(),
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "classes": classes.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Classes {
  Class1Class? class1;
  Class1Class? class2;
  Class1Class? class3;
  Class1Class? class4;
  Class1Class? class5;
  Class1Class? class6;
  Class1Class? class7;
  Class1Class? class8;
  Class1Class? class9;
  Class1Class? class10;
  Class1Class? class11;
  Class1Class? class12;

  Classes({
    this.class1,
    this.class2,
    this.class3,
    this.class4,
    this.class5,
    this.class6,
    this.class7,
    this.class8,
    this.class9,
    this.class10,
    this.class11,
    this.class12,
  });

  factory Classes.fromRawJson(String str) => Classes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
    class1: json["class1"] != null ? Class1Class.fromJson(json["class1"]) : null,
    class2: json["class2"] != null ? Class1Class.fromJson(json["class2"]) : null,
    class3: json["class3"] != null ? Class1Class.fromJson(json["class3"]) : null,
    class4: json["class4"] != null ? Class1Class.fromJson(json["class4"]) : null,
    class5: json["class5"] != null ? Class1Class.fromJson(json["class5"]) : null,
    class6: json["class6"] != null ? Class1Class.fromJson(json["class6"]) : null,
    class7: json["class7"] != null ? Class1Class.fromJson(json["class7"]) : null,
    class8: json["class8"] != null ? Class1Class.fromJson(json["class8"]) : null,
    class9: json["class9"] != null ? Class1Class.fromJson(json["class9"]) : null,
    class10: json["class10"] != null ? Class1Class.fromJson(json["class10"]) : null,
    class11: json["class11"] != null ? Class1Class.fromJson(json["class11"]) : null,
    class12: json["class12"] != null ? Class1Class.fromJson(json["class12"]) : null,
  );

  Map<String, dynamic> toJson() => {
    if (class1 != null) "class1": class1!.toJson(),
    if (class2 != null) "class2": class2!.toJson(),
    if (class3 != null) "class3": class3!.toJson(),
    if (class4 != null) "class4": class4!.toJson(),
    if (class5 != null) "class5": class5!.toJson(),
    if (class6 != null) "class6": class6!.toJson(),
    if (class7 != null) "class7": class7!.toJson(),
    if (class8 != null) "class8": class8!.toJson(),
    if (class9 != null) "class9": class9!.toJson(),
    if (class10 != null) "class10": class10!.toJson(),
    if (class11 != null) "class11": class11!.toJson(),
    if (class12 != null) "class12": class12!.toJson(),
  };
}

class Class1Class {
  bool isStudied;
  String branch;

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

class UsersDropdownModel {
  final String id;
  final String name;
  final String fatherName;
  final String surname;
  final String role;

  UsersDropdownModel({
    required this.id,
    required this.name,
    required this.fatherName,
    required this.surname,
    required this.role,
  });

  factory UsersDropdownModel.fromRawJson(String str) =>
      UsersDropdownModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UsersDropdownModel.fromJson(Map<String, dynamic> json) =>
      UsersDropdownModel(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        fatherName: json["fatherName"] ?? "",
        surname: json["surname"] ?? "",
        role: json["role"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "fatherName": fatherName,
    "surname": surname,
    "role": role,
  };
}

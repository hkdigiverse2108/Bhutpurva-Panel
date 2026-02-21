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
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    fatherName: json["fatherName"],
    surname: json["surname"],
    phoneNumber: json["phoneNumber"],
    whatsappNumber: json["whatsappNumber"],
    gender: json["gender"],
    hrNo: json["hrNo"],
    role: json["role"],
    currentCity: json["currentCity"],
    addressIds: List<AddressId>.from(
      json["addressIds"].map((x) => AddressId.fromJson(x)),
    ),
    occupation: json["occupation"],
    professions: List<String>.from(json["professions"].map((x) => x)),
    educations: List<dynamic>.from(json["educations"].map((x) => x)),
    maritalStatus: json["maritalStatus"],
    bloodGroup: json["bloodGroup"],
    class10: Class12Class.fromJson(json["class10"]),
    class12: Class12Class.fromJson(json["class12"]),
    studyId: json["studyId"] == null ? null : StudyId.fromJson(json["studyId"]),
    skill: json["skill"],
    talents: List<String>.from(json["talents"].map((x) => x)),
    awards: List<String>.from(json["awards"].map((x) => x)),
    isDeleted: json["isDeleted"],
    otp: json["otp"],
    isVerified: json["isVerified"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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
    id: json["_id"],
    address: json["address"],
    type: json["type"],
    city: json["city"],
    district: json["district"],
    state: json["state"],
    country: json["country"],
    pincode: json["pincode"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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
    class1Class: json["class"],
    isStudded: json["isStudded"],
    branch: json["branch"],
    passingYear: json["passingYear"],
    medium: json["medium"],
    hostel: json["hostel"],
    id: json["_id"],
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
    id: json["_id"],
    classes: Classes.fromJson(json["classes"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "classes": classes.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Classes {
  Class1Class class1;
  Class1Class class10;

  Classes({required this.class1, required this.class10});

  factory Classes.fromRawJson(String str) => Classes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
    class1: Class1Class.fromJson(json["class1"]),
    class10: Class1Class.fromJson(json["class10"]),
  );

  Map<String, dynamic> toJson() => {
    "class1": class1.toJson(),
    "class10": class10.toJson(),
  };
}

class Class1Class {
  bool isStudied;
  String branch;

  Class1Class({required this.isStudied, required this.branch});

  factory Class1Class.fromRawJson(String str) =>
      Class1Class.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Class1Class.fromJson(Map<String, dynamic> json) =>
      Class1Class(isStudied: json["isStudied"], branch: json["branch"]);

  Map<String, dynamic> toJson() => {"isStudied": isStudied, "branch": branch};
}

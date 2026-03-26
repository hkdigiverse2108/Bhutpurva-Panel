import 'dart:convert';

class SettingModel {
  final Setting? setting;

  SettingModel({this.setting});

  factory SettingModel.fromRawJson(String str) =>
      SettingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    setting: json["setting"] == null ? null : Setting.fromJson(json["setting"]),
  );

  Map<String, dynamic> toJson() => {"setting": setting?.toJson()};
}

class Setting {
  final String? id;
  final String? address;
  final String? appName;
  final String? appStoreId;
  final String? appStoreUrl;
  final DateTime? createdAt;
  final String? logo;
  final String? playStoreId;
  final String? playStoreUrl;
  final String? sgsiPdf;
  final String? anubhutiImage;
  final String? lifeLightImage;
  final SocialLinks? socialLinks;
  final String? supportEmail;
  final String? supportPhone;
  final String? supportWhatsApp;
  final DateTime? updatedAt;
  final String? webSiteUrl;
  final String? appUrl;
  final String? aboutApp;
  final String? privacyPolicy;
  final String? activistPolicy;

  Setting({
    this.id,
    this.address,
    this.appName,
    this.appStoreId,
    this.appStoreUrl,
    this.createdAt,
    this.logo,
    this.playStoreId,
    this.playStoreUrl,
    this.anubhutiImage,
    this.lifeLightImage,
    this.sgsiPdf,
    this.socialLinks,
    this.supportEmail,
    this.supportPhone,
    this.supportWhatsApp,
    this.updatedAt,
    this.webSiteUrl,
    this.appUrl,
    this.aboutApp,
    this.privacyPolicy,
    this.activistPolicy,
  });

  factory Setting.fromRawJson(String str) => Setting.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    id: json["_id"],
    address: json["address"],
    appName: json["appName"],
    appStoreId: json["appStoreId"],
    appStoreUrl: json["appStoreUrl"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    logo: json["logo"],
    playStoreId: json["playStoreId"],
    playStoreUrl: json["playStoreUrl"],
    anubhutiImage: json["anubhutiImage"],
    lifeLightImage: json["lifeLightImage"],
    sgsiPdf: json["sgsiPdf"],
    socialLinks: json["socialLinks"] == null
        ? null
        : SocialLinks.fromJson(json["socialLinks"]),
    supportEmail: json["supportEmail"],
    supportPhone: json["supportPhone"],
    supportWhatsApp: json["supportWhatsApp"],
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    webSiteUrl: json["webSiteUrl"],
    appUrl: json["appUrl"],
    aboutApp: json["aboutApp"],
    privacyPolicy: json["privacyPolicy"],
    activistPolicy: json["activistPolicy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "address": address,
    "appName": appName,
    "appStoreId": appStoreId,
    "appStoreUrl": appStoreUrl,
    "createdAt": createdAt?.toIso8601String(),
    "logo": logo,
    "playStoreId": playStoreId,
    "playStoreUrl": playStoreUrl,
    "anubhutiImage": anubhutiImage,
    "lifeLightImage": lifeLightImage,
    "sgsiPdf": sgsiPdf,
    "socialLinks": socialLinks?.toJson(),
    "supportEmail": supportEmail,
    "supportPhone": supportPhone,
    "supportWhatsApp": supportWhatsApp,
    "updatedAt": updatedAt?.toIso8601String(),
    "webSiteUrl": webSiteUrl,
    "appUrl": appUrl,
    "aboutApp": aboutApp,
    "privacyPolicy": privacyPolicy,
    "activistPolicy": activistPolicy,
  };
}

class SocialLinks {
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? linkedin;
  final String? youtube;
  final String? whatsapp;
  final String? id;

  SocialLinks({
    this.facebook,
    this.instagram,
    this.twitter,
    this.linkedin,
    this.youtube,
    this.whatsapp,
    this.id,
  });

  factory SocialLinks.fromRawJson(String str) =>
      SocialLinks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
    facebook: json["facebook"],
    instagram: json["instagram"],
    twitter: json["twitter"],
    linkedin: json["linkedin"],
    youtube: json["youtube"],
    whatsapp: json["whatsapp"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook,
    "instagram": instagram,
    "twitter": twitter,
    "linkedin": linkedin,
    "youtube": youtube,
    "whatsapp": whatsapp,
    "_id": id,
  };
}

class LegalityModel {
  final String? id;
  final String? type;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LegalityModel({
    this.id,
    this.type,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory LegalityModel.fromRawJson(String str) =>
      LegalityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LegalityModel.fromJson(Map<String, dynamic> json) => LegalityModel(
    id: json["_id"],
    type: json["type"],
    content: json["content"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "content": content,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

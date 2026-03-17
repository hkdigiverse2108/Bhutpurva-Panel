class AnubhutiModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String message;
  final String createdAt;

  const AnubhutiModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.message,
    required this.createdAt,
  });

  factory AnubhutiModel.fromJson(Map<String, dynamic> json) {
    return AnubhutiModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      message: json['message'],
      createdAt: json['createdAt'],
    );
  }
}

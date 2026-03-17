class StudentModel {
  final String id;
  final String image;
  final String name;
  final String address;
  final String phone;
  final String email;
  final int age;
  final String profileStatus;

  StudentModel({
    required this.id,
    required this.image,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.age,
    required this.profileStatus,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['_id'],
      image: json['image'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      age: json['age'],
      profileStatus: json['profileStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'age': age,
      'profileStatus': profileStatus,
    };
  }
}

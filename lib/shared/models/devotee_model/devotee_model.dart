class DevoteeModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;

  DevoteeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory DevoteeModel.empty() {
    return DevoteeModel(id: '', name: '', email: '', phone: '', address: '');
  }
}

class MoniterModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;

  MoniterModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });
  factory MoniterModel.empty() {
    return MoniterModel(id: '', name: '', email: '', phone: '', address: '');
  }
}

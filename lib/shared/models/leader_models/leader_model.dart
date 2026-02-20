class LeaderModel {
  final String name;
  final String email;
  final String phone;

  LeaderModel({required this.name, required this.email, required this.phone});

  factory LeaderModel.empty() {
    return LeaderModel(name: '', email: '', phone: '');
  }
}

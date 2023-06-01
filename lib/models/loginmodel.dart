class LoginModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String refresh;
  final String access;

  LoginModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.refresh,
    required this.access,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      refresh: json['refresh'],
      access: json['access'],
    );
  }
}

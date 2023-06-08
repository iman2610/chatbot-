class LoginModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String profile;
  final String refresh;
  final String access;

  LoginModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.refresh,
    required this.access,
    required this.profile,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      refresh: json['refresh'],
      access: json['access'],
      profile: json['profile'],
    );
  }
}
class DataModel {
  final int id;
  final String name;
  final String phone;
  final String email;


  DataModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
   
  });
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }
}

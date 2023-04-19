import 'package:diploma_frontend/enums/role.dart';

class User {
  final String token;
  final int id;
  final Role role;

  User({
    required this.id,
    required this.token,
    required this.role,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      token: json['token'],
      role: json['role'].toString().getRole(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'role': role.getName(),
    };
  }
}

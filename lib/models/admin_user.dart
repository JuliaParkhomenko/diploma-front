import 'package:diploma_frontend/enums/role.dart';

class AdminUser {
  final int id;
  final String fullName;
  final String email;
  final Role role;

  AdminUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'].toString().getRole(),
    );
  }
}

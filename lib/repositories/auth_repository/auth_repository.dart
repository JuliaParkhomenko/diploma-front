import 'dart:convert';
import 'dart:developer';

import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/enums/role.dart';
import 'package:diploma_frontend/repositories/auth_repository/base_auth_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepository implements BaseAuthRepository {
  @override
  Future<User?> registration({
    required String email,
    required String password,
    required Role role,
    required String fullName,
  }) async {
    try {
      final Uri uri = Uri.parse('https://localhost:7037/api/User/signup');
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'email': email,
        'password': password,
        'role': role.getName(),
        'fullName': fullName,
      });
      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final Uri uri = Uri.parse('https://localhost:7037/api/User/signin');
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'email': email,
        'password': password,
      });
      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

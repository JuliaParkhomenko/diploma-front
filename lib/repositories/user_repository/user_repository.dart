import 'dart:convert';
import 'dart:developer';

import 'package:diploma_frontend/enums/role.dart';
import 'package:diploma_frontend/models/admin_user.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/repositories/user_repository/base_user_repository.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:http/http.dart' as http;

class UserRepository extends BaseUserRepository {
  final Database _database;
  UserRepository(this._database);

  @override
  Future<List<AdminUser>?> getUsers() async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/User/all',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<AdminUser>((e) {
          return AdminUser.fromJson(e);
        }).toList();
      } else if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<void> addUser({
    required AdminUser aUser,
    required String password,
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/User/signup',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode({
        'email': aUser.email,
        'password': password,
        'fullName': aUser.fullName,
        'role': aUser.role.getName(),
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

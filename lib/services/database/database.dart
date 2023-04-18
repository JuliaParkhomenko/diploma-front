import 'dart:convert';

import 'package:diploma_frontend/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  final String _userKey = 'user';
  Future<void> addUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _userKey,
      jsonEncode(user.toJson()),
    );
  }

  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString(_userKey);
    if (user == null) {
      return null;
    }
    return User.fromJson(jsonDecode(user));
  }

  Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

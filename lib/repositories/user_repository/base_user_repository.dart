import 'package:diploma_frontend/models/admin_user.dart';

abstract class BaseUserRepository {
  Future<List<AdminUser>?> getUsers();
  Future<void> addUser({required AdminUser aUser, required String password});
  Future<List<AdminUser>?> getManagers();
}

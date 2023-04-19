import 'package:diploma_frontend/enums/role.dart';
import 'package:diploma_frontend/models/user.dart';

abstract class BaseAuthRepository {
  Future<User?> signIn({
    required String email,
    required String password,
  });

  Future<User?> registration({
    required String email,
    required String password,
    required Role role,
    required String fullName,
  });
}

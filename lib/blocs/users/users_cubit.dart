import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/admin_user.dart';
import 'package:diploma_frontend/repositories/user_repository/user_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UserRepository _repository;
  UsersCubit(this._repository) : super(UsersInitial());

  Future<void> fetchUsers() async {
    try {
      emit(UsersLoading());
      final List<AdminUser>? users = await _repository.getUsers();
      emit(UsersLoaded(users!));
    } catch (error) {
      emit(UsersError(error.toString()));
    }
  }

  void clear() {
    emit(UsersInitial());
  }

  Future<void> addUser({
    required AdminUser user,
    required String password,
  }) async {
    try {
      await _repository.addUser(aUser: user, password: password);
      await fetchUsers();
    } catch (_) {}
  }

  Future<void> updateUser({
    required AdminUser user,
    String? password,
  }) async {
    try {
      // await _repository.
    } catch (_) {}
  }
}

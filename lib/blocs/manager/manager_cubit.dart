import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/admin_user.dart';
import 'package:diploma_frontend/repositories/user_repository/user_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'manager_state.dart';

class ManagerCubit extends Cubit<ManagerState> {
  final UserRepository _repository;
  ManagerCubit(this._repository) : super(ManagerInitial());

  Future<void> fetchManagers() async {
    try {
      final List<AdminUser>? managers = await _repository.getManagers();
      emit(ManagerLoaded(managers!));
    } catch (_) {}
  }

  void clear() {
    emit(ManagerInitial());
  }
}

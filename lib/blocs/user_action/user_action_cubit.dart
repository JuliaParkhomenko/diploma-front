import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/user_action.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/warehouse_repository.dart';
import 'package:meta/meta.dart';

part 'user_action_state.dart';

class UserActionCubit extends Cubit<UserActionState> {
  final WarehouseRepository _repository;
  UserActionCubit(this._repository) : super(UserActionInitial());

  Future<void> fetchUserActions(int warehouseId) async {
    try {
      emit(UserActionLoading());
      final List<UserAction>? products =
          await _repository.recentActions(warehouseId: warehouseId);
      emit(UserActionLoaded(products!));
    } catch (e) {
      emit(UserActionError(e.toString()));
    }
  }

//TODO: Yuliia`s question. Do we need this function?
  void clear() {
    emit(UserActionInitial());
  }
}

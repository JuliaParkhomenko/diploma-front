import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/warehouse_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  final WarehouseRepository _repository;
  ApplicationCubit(this._repository) : super(ApplicationInitial());

  Future<void> fetchApplications({
    required String warehouseName,
    required bool past,
  }) async {
    try {
      emit(ApplicationLoading());
      final List<Application>? applications = await _repository.getApplications(
        past: past,
        warehouseName: warehouseName,
      );
      emit(ApplicationLoaded(applications!));
    } catch (e) {
      emit(ApplicationError(e.toString()));
    }
  }

  void clear() {
    emit(ApplicationInitial());
  }
}

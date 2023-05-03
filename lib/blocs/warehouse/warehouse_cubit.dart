import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/warehouse.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/warehouse_repository.dart';
import 'package:meta/meta.dart';

part 'warehouse_state.dart';

class WarehouseCubit extends Cubit<WarehouseState> {
  final WarehouseRepository _repository;
  WarehouseCubit(this._repository) : super(WarehouseInitial());

  Future<void> fetchWarehouses() async {
    try {
      emit(WarehouseLoading());
      final List<Warehouse>? warehouses = await _repository.getWarehouses();
      emit(WarehouseLoaded(warehouses!));
    } catch (e) {
      emit(WarehouseError(e.toString()));
    }
  }
}

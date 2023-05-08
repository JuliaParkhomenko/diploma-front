import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/warehouse.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/warehouse_repository.dart';
import 'package:meta/meta.dart';

part 'warehouse_state.dart';

class WarehouseCubit extends Cubit<WarehouseState> {
  final WarehouseRepository _repository;
  WarehouseCubit(this._repository) : super(WarehouseInitial());

  int selectedWarehouseIndex = 0;

  Future<void> fetchWarehouses() async {
    try {
      emit(WarehouseLoading());
      final List<Warehouse>? warehouses = await _repository.getWarehouses();
      if (warehouses != null &&
          warehouses.isNotEmpty &&
          selectedWarehouseIndex == 0) {
        selectedWarehouseIndex = warehouses.first.id;
      }
      emit(WarehouseLoaded(warehouses!));
    } catch (e) {
      emit(WarehouseError(e.toString()));
    }
  }
}

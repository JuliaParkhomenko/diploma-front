import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/warehouse.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/warehouse_repository.dart';
// ignore: depend_on_referenced_packages
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

  Future<void> fetchWarehousesForAdmin() async {
    try {
      emit(WarehouseLoading());
      final List<Warehouse>? warehouses =
          await _repository.getWarehousesForAdmin();

      emit(WarehouseLoaded(warehouses!));
    } catch (e) {
      emit(WarehouseError(e.toString()));
    }
  }

  Future<void> addWarehouse({
    required String name,
    required String address,
    required num manager,
    required num maxFamount,
    required num maxCamount,
    required num maxFridgeAmount,
  }) async {
    try {
      await _repository.add(
        name: name,
        address: address,
        manager: manager.toInt(),
        maxFamount: maxFamount.toInt(),
        maxCamount: maxCamount.toInt(),
        maxFridgeAmount: maxFridgeAmount.toInt(),
      );
      await fetchWarehousesForAdmin();
    } catch (_) {}
  }

  void clear() {
    emit(WarehouseInitial());
  }
}

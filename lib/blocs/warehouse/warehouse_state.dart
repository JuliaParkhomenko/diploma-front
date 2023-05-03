part of 'warehouse_cubit.dart';

@immutable
abstract class WarehouseState {}

class WarehouseInitial extends WarehouseState {}

class WarehouseLoading extends WarehouseState {}

class WarehouseLoaded extends WarehouseState {
  final List<Warehouse> warehouses;

  WarehouseLoaded(this.warehouses);
}

class WarehouseError extends WarehouseState {
  final String error;
  WarehouseError(this.error);
}

part of 'batch_supply_cubit.dart';

@immutable
abstract class BatchSupplyState {}

class BatchSupplyInitial extends BatchSupplyState {}

class BatchSupplyLoading extends BatchSupplyState {}

class BatchSupplyLoaded extends BatchSupplyState {
  final List<BatchSupply> supplies;
  BatchSupplyLoaded(this.supplies);
}

class BatchSupplyError extends BatchSupplyState {
  final String error;
  BatchSupplyError(this.error);
}

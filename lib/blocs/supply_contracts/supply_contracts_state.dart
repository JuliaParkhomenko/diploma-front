part of 'supply_contracts_cubit.dart';

@immutable
abstract class SupplyContractsState {}

class SupplyContractsInitial extends SupplyContractsState {}

class SupplyContractsLoading extends SupplyContractsState {}

class SupplyContractsLoaded extends SupplyContractsState {
  final List<SupplyContract> contracts;
  SupplyContractsLoaded(this.contracts);
}

class SupplyContractsError extends SupplyContractsState {
  final String error;
  SupplyContractsError(this.error);
}

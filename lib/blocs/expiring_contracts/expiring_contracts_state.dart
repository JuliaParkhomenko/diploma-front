part of 'expiring_contracts_cubit.dart';

@immutable
abstract class ExpiringContractsState {}

class ExpiringContractsInitial extends ExpiringContractsState {}

class ExpiringContractsLoading extends ExpiringContractsState {}

class ExpiringContractsLoaded extends ExpiringContractsState {
  final List<ExpiringContract> expiringContracts;
  ExpiringContractsLoaded(
    this.expiringContracts,
  );
}

class ExpiringContractsError extends ExpiringContractsState {
  final String error;
  ExpiringContractsError(this.error);
}

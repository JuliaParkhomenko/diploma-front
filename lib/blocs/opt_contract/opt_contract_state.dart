part of 'opt_contract_cubit.dart';

@immutable
abstract class OptContractState {}

class OptContractInitial extends OptContractState {}

class OptContractLoaded extends OptContractState {
  final List<OptContractModel> contracts;
  OptContractLoaded(this.contracts);
}

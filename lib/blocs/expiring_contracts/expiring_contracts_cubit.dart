import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/expiring_contracts.dart';
import 'package:diploma_frontend/repositories/supplier_repository/supplier_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'expiring_contracts_state.dart';

class ExpiringContractsCubit extends Cubit<ExpiringContractsState> {
  final SupplierRepository _repository;
  ExpiringContractsCubit(this._repository) : super(ExpiringContractsInitial());

  Future<void> featchExpiringContracts({
    required int limit,
  }) async {
    try {
      emit(ExpiringContractsLoading());
      final List<ExpiringContract>? expiringContracts =
          await _repository.expiringContracts(
        limit: limit,
      );
      emit(ExpiringContractsLoaded(expiringContracts!));
    } catch (e) {
      emit(ExpiringContractsError(e.toString()));
    }
  }

  void clear() {
    emit(ExpiringContractsInitial());
  }
}

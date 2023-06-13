import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/supply_contract.dart';
import 'package:diploma_frontend/repositories/supplier_repository/supplier_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'supply_contracts_state.dart';

class SupplyContractsCubit extends Cubit<SupplyContractsState> {
  final SupplierRepository _repository;
  SupplyContractsCubit(this._repository) : super(SupplyContractsInitial());

  Future<void> featchContracts({
    required bool old,
    String productName = '',
    String supplierName = '',
    String maker = '',
  }) async {
    try {
      emit(SupplyContractsLoading());
      final List<SupplyContract>? contracts =
          await _repository.supplierContracts(
        old: old,
        productName: productName,
        supplierName: supplierName,
        maker: maker,
      );
      emit(SupplyContractsLoaded(contracts!));
    } catch (e) {
      emit(SupplyContractsError(e.toString()));
    }
  }

  void clear() {
    emit(SupplyContractsInitial());
  }
}

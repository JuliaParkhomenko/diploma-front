import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/opt_contract_model.dart';
import 'package:diploma_frontend/repositories/product_repository/product_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'opt_contract_state.dart';

class OptContractCubit extends Cubit<OptContractState> {
  final ProductRepository _repository;
  OptContractCubit(this._repository) : super(OptContractInitial());

  Future<void> fetchContracts(int productId) async {
    try {
      final List<OptContractModel>? contracts =
          await _repository.getContracts(productId: productId);
      emit(OptContractLoaded(contracts!));
    } catch (_) {
      log(_.toString());
    }
  }

  void clear() {
    emit(OptContractInitial());
  }
}

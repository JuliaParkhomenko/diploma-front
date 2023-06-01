import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/batch_supply.dart';
import 'package:diploma_frontend/repositories/batch_repository/batch_repository.dart';
import 'package:meta/meta.dart';

part 'batch_supply_state.dart';

class BatchSupplyCubit extends Cubit<BatchSupplyState> {
  final BatchRepository _repository;
  BatchSupplyCubit(this._repository) : super(BatchSupplyInitial());

  Future<void> featchSupplies(
      {String productName = '', String warehouseName = ''}) async {
    try {
      emit(BatchSupplyLoading());
      final List<BatchSupply>? supplies = await _repository.getSupplies(
        productName: productName,
        warehouseName: warehouseName,
      );
      emit(BatchSupplyLoaded(supplies!));
    } catch (e) {
      emit(BatchSupplyError(e.toString()));
    }
  }

  void clear() {
    emit(BatchSupplyInitial());
  }
}

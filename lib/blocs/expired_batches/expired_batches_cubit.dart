import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/expiring_batch.dart';
import 'package:diploma_frontend/repositories/batch_repository/batch_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'expired_batches_state.dart';

class ExpiredBatchesCubit extends Cubit<ExpiredBatchesState> {
  final BatchRepository _repository;
  ExpiredBatchesCubit(this._repository) : super(ExpiredBatchesInitial());

  Future<void> fetchExpiredBatches(
    int warehouseId,
    int amount,
  ) async {
    try {
      emit(ExpiredBatchesLoading());
      final List<ExpiringBatch>? expiredBatches = await _repository
          .expiredBatches(warehouseId: warehouseId, amount: amount);
      emit(ExpiredBatchesLoaded(expiredBatches!));
    } catch (e) {
      emit(ExpiredBatchesError(e.toString()));
    }
  }

  void clear() {
    emit(ExpiredBatchesInitial());
  }
}

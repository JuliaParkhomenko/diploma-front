import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/expiring_batch.dart';
import 'package:diploma_frontend/repositories/batch_repository/batch_repository.dart';
import 'package:meta/meta.dart';

part 'expiring_batches_state.dart';

class ExpiringBatchesCubit extends Cubit<ExpiringBatchesState> {
  final BatchRepository _repository;
  ExpiringBatchesCubit(this._repository) : super(ExpiringBatchesInitial());

  Future<void> fetchExpiringBatches(
    int warehouseId,
    int amount,
  ) async {
    try {
      emit(ExpiringBatchesLoading());
      final List<ExpiringBatch>? expiringBatches = await _repository
          .expiringBatches(warehouseId: warehouseId, amount: amount);
      emit(ExpiringBatchesLoaded(expiringBatches!));
    } catch (e) {
      emit(ExpiringBatchesError(e.toString()));
    }
  }

  void clear() {
    emit(ExpiringBatchesInitial());
  }
}

import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/ordered_batch.dart';
import 'package:diploma_frontend/repositories/batch_repository/batch_repository.dart';
import 'package:meta/meta.dart';

part 'ordered_batches_state.dart';

class OrderedBatchesCubit extends Cubit<OrderedBatchesState> {
  final BatchRepository _repository;
  OrderedBatchesCubit(this._repository) : super(OrderedBatchesInitial());
  OrderedBatch? orderedBatch;

  Future<void> fetchBatch(
    int id, {
    String productName = '',
    String batchId = '',
    String kind = '',
  }) async {
    try {
      emit(OrderedBatchesLoading());
      final List<OrderedBatch>? orderedBatches =
          await _repository.orderedBatches(
        warehouseId: id,
        productName: productName,
        batchId: batchId,
        kind: kind,
      );
      emit(OrderedBatchesLoaded(orderedBatches!));
    } catch (_) {
      emit(OrderedBatchesError(_.toString()));
    }
  }

  void clear() {
    emit(OrderedBatchesInitial());
  }
}

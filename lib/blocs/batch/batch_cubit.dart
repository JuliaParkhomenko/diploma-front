import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/batch.dart';
import 'package:diploma_frontend/repositories/batch_repository/batch_repository.dart';
import 'package:meta/meta.dart';

part 'batch_state.dart';

class BatchCubit extends Cubit<BatchState> {
  final BatchRepository _repository;
  BatchCubit(this._repository) : super(BatchInitial());

  Future<void> fetchBatch(int id) async {
    try {
      emit(BatchLoading());
      final Batch? batch = await _repository.getBatch(id: id);
      emit(BatchLoaded(batch!));
    } catch (_) {
      emit(BatchError(_.toString()));
    }
  }

  void clear() {
    emit(BatchInitial());
  }
}

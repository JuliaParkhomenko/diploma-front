import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/repositories/product_repository/product_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'kind_state.dart';

class KindCubit extends Cubit<KindState> {
  final ProductRepository _repository;
  KindCubit(this._repository) : super(KindInitial());
  String? orderedkindBatch;

  Future<void> fetchKind(
    int productId,
  ) async {
    try {
      emit(KindLoading());
      final List<String>? orderedBatches = await _repository.getKinds(
        productId: productId,
      );
      emit(KindLoaded(orderedBatches!));
    } catch (_) {
      emit(KindError(_.toString()));
    }
  }

  void clear() {
    emit(KindInitial());
  }
}

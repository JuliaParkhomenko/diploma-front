import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/batch.dart';
import 'package:diploma_frontend/repositories/batch_repository/batch_repository.dart';
import 'package:meta/meta.dart';

part 'specific_product_state.dart';

class SpecificProductCubit extends Cubit<SpecificProductState> {
  final BatchRepository _repository;
  SpecificProductCubit(this._repository) : super(SpecificProductInitial());

  Future<void> fetchBatches(int productId) async {
    try {
      emit(SpecificProductLoading());
      final List<Batch>? batches = await _repository.forStock(id: productId);
      emit(SpecificProductLoaded(batches!));
    } catch (e) {
      log(e.toString());
      emit(SpecificProductError(e.toString()));
    }
  }
}

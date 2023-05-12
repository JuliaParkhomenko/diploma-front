import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/enums/specific_product_filter.dart';
import 'package:diploma_frontend/models/batch.dart';
import 'package:diploma_frontend/repositories/batch_repository/batch_repository.dart';
import 'package:meta/meta.dart';

part 'specific_product_state.dart';

class SpecificProductCubit extends Cubit<SpecificProductState> {
  final BatchRepository _repository;
  SpecificProductCubit(this._repository) : super(SpecificProductInitial());

  late Batch? batch;

  Future<void> fetchBatches(
    int productId, {
    String batchId = '',
    String kind = '',
    String maker = '',
    String status = '',
  }) async {
    try {
      emit(SpecificProductLoading());
      final List<Batch>? batches = await _repository.forStock(
        id: productId,
        batchId: batchId,
        kind: kind,
        maker: maker,
        status: status,
      );
      filterBatches(SpecificProductFilter.expirationUp, batches!);
    } catch (e) {
      log(e.toString());
      emit(SpecificProductError(e.toString()));
    }
  }

  void filterBatches(SpecificProductFilter filter, List<Batch> list) {
    if (filter == SpecificProductFilter.amountDown) {
      list.sort((a, b) => b.amount.compareTo(a.amount));
    }
    if (filter == SpecificProductFilter.amountUp) {
      list.sort((a, b) => a.amount.compareTo(b.amount));
    }

    if (filter == SpecificProductFilter.expirationDown) {
      list.sort((a, b) => b.expirationDate.compareTo(a.expirationDate));
    }
    if (filter == SpecificProductFilter.expirationUp) {
      list.sort((a, b) => a.expirationDate.compareTo(b.expirationDate));
    }

    if (filter == SpecificProductFilter.idDown) {
      list.sort((a, b) => b.id.compareTo(a.id));
    }
    if (filter == SpecificProductFilter.idUp) {
      list.sort((a, b) => a.id.compareTo(b.id));
    }

    emit(SpecificProductLoaded(list, filter));
  }
}

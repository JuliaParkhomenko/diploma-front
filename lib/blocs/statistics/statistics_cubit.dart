import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/statistics.dart';
import 'package:diploma_frontend/repositories/statistics/statistics_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final StatisticsRepository _repository;
  StatisticsCubit(this._repository) : super(StatisticsInitial());
  Future<void> fetchStatistics(int warehouseId) async {
    try {
      emit(StatisticsLoading());
      final List<Statistics>? statistics =
          await _repository.product(warehouseId: warehouseId);
      emit(StatisticsLoaded(statistics!));
    } catch (_) {
      log(_.toString());
      emit(StatisticsError(_.toString()));
    }
  }

  void clear() {
    emit(StatisticsInitial());
  }
}

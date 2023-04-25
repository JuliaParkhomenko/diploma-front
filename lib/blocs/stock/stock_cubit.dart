import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/enums/stocks_filter.dart';
import 'package:diploma_frontend/models/stock.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/warehouse_repository.dart';
import 'package:meta/meta.dart';

part 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  final WarehouseRepository _repository;
  StockCubit(this._repository) : super(StockInitial());
  Future<void> fetchStocks(int id) async {
    try {
      emit(StockLoading());
      final List<Stock>? stocks = await _repository.getStockByWarehouse(id: id);
      emit(StockLoaded(stocks!, StockFilter.none));
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }

  void filterStocks(StockFilter filter, List<Stock> list) {
    if (filter == StockFilter.productUp) {
      list.sort((a, b) => a.productName.compareTo(b.productName));
      emit(StockLoaded(list, filter));
      return;
    }

    if (filter == StockFilter.productDown) {
      list.sort((a, b) => b.productName.compareTo(a.productName));
      emit(StockLoaded(list, filter));
      return;
    }

    if (filter == StockFilter.amountUp) {
      list.sort((a, b) => a.amount.compareTo(b.amount));
      emit(StockLoaded(list, filter));
      return;
    }

    if (filter == StockFilter.amountDown) {
      list.sort((a, b) => b.amount.compareTo(a.amount));
      emit(StockLoaded(list, filter));
      return;
    }

    if (filter == StockFilter.orderedUp) {
      list.sort((a, b) => a.ordered.compareTo(b.ordered));
      emit(StockLoaded(list, filter));
      return;
    }

    if (filter == StockFilter.orderedDown) {
      list.sort((a, b) => b.ordered.compareTo(a.ordered));
      emit(StockLoaded(list, filter));
      return;
    }

    if (filter == StockFilter.totalUp) {
      list.sort((a, b) => a.total.compareTo(b.total));
      emit(StockLoaded(list, filter));
      return;
    }

    if (filter == StockFilter.totalDown) {
      list.sort((a, b) => b.total.compareTo(a.total));
      emit(StockLoaded(list, filter));
      return;
    }
  }
}

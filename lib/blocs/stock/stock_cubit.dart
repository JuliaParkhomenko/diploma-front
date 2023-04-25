import 'package:bloc/bloc.dart';
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
      print(stocks);
      emit(StockLoaded(stocks!));
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }
}

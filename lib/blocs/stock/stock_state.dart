part of 'stock_cubit.dart';

@immutable
abstract class StockState {}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final List<Stock> stocks;
  final StockFilter filter;

  StockLoaded(this.stocks, this.filter);
}

class StockError extends StockState {
  final String error;
  StockError(this.error);
}

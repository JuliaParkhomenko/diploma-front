import 'package:diploma_frontend/models/stock.dart';

abstract class BaseWarehouseRepository {
  Future<List<Stock>?> getStockByWarehouse({
    required int id,
  });
}

import 'package:diploma_frontend/models/stock.dart';
import 'package:diploma_frontend/models/warehouse.dart';

abstract class BaseWarehouseRepository {
  Future<List<Stock>?> getStockByWarehouse({
    required int id,
    required String productName,
  });

  Future<List<Warehouse>?> getWarehouses();
}

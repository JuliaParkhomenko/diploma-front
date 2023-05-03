import 'dart:convert';
import 'dart:developer';

import 'package:diploma_frontend/models/stock.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/models/warehouse.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/base_warehouse_repository.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:http/http.dart' as http;

class WarehouseRepository implements BaseWarehouseRepository {
  final Database _database;
  WarehouseRepository(this._database);

  @override
  Future<List<Stock>?> getStockByWarehouse({
    required int id,
    required String productName,
  }) async {
    try {
      final User? user = await _database.getUser();
      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Warehouse/stocksforwarehouse?warehouseId=$id&productName=$productName',
      );
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<Stock>((e) {
          return Stock.fromJson(e);
        }).toList();
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<List<Warehouse>?> getWarehouses() async {
    try {
      final User? user = await _database.getUser();
      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Warehouse/all',
      );
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<Warehouse>((e) {
          return Warehouse.fromJson(e);
        }).toList();
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:diploma_frontend/models/stock.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/base_warehouse_repository.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:http/http.dart' as http;

class WarehouseRepository implements BaseWarehouseRepository {
  @override
  Future<List<Stock>?> getStockByWarehouse({required int id}) async {
    try {
      final User? user = await Database().getUser();
      final Uri url = Uri.parse(
          'https://restaurant-warehouse.azurewebsites.net/api/Warehouse/stocksforwarehouse?warehouseId=$id');
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };
      final response = await http.get(url, headers: headers);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<Stock>((e) => Stock.fromJson(e)).toList();
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

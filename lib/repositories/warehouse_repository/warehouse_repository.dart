import 'dart:convert';
import 'dart:developer';

import 'package:diploma_frontend/models/stock.dart';
import 'package:diploma_frontend/models/storage.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/models/warehouse.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/base_warehouse_repository.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:diploma_frontend/enums/urgency.dart';
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

  @override
  Future<int?> add({
    required String name,
    required String address,
    required List<String> managers,
    required List<Storage> storages,
  }) async {
    try {
      final User? user = await Database().getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Warehouse/add',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode({
        'name': name,
        'address': address,
        'managers': managers,
        'storages': storages.map((e) {
          return e.toJson();
        }).toList(),
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['id'];
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<int?> addAplication({
    required int warehouseId,
    required int productId,
    required int amount,
    required String kind,
    required Urgency urgency,
    required String note,
  }) async {
    try {
      final User? user = await Database().getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Warehouse/addAplication',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode({
        'warehouseId': warehouseId,
        'productId': productId,
        'amount': amount,
        'kind': kind,
        'urgency': urgency.getUrgency(),
        'note': note,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['id'];
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<void> assignManager({
    required int warehouseId,
    required String email,
  }) async {
    try {
      final User? user = await Database().getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Warehouse/assignManager',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode({
        'warehouseId': warehouseId,
        'email': email,
      });

      await http.post(url, headers: headers, body: body);
    } catch (e) {
      log(e.toString());
    }
  }
}

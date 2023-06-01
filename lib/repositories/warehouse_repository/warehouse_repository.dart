import 'dart:convert';
import 'dart:developer';

import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/models/stock.dart';
import 'package:diploma_frontend/models/storage.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/models/user_action.dart';
import 'package:diploma_frontend/models/warehouse.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/base_warehouse_repository.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:diploma_frontend/enums/urgency.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
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
      } else if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
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
      } else if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
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
      } else if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
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
    required BuildContext context,
  }) async {
    try {
      final User? user = await Database().getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Warehouse/addApplication',
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
        // ignore: use_build_context_synchronously
        'urgency': urgency.getUrgency(context),
        'note': note,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['id'];
      } else if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
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

      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<UserAction>?> recentActions({
    required int warehouseId,
  }) async {
    try {
      final User? user = await _database.getUser();
      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Warehouse/recentActions?warehouseId=$warehouseId',
      );
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<UserAction>((e) {
          return UserAction.fromJson(e);
        }).toList();
      } else if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<List<Application>?> getApplications({
    String warehouseName = '',
    required bool past,
  }) async {
    try {
      final User? user = await _database.getUser();
      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Warehouse/getApplications?past=$past&warehouseName=$warehouseName',
      );
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<Application>((e) {
          return Application.fromJson(e);
        }).toList();
      } else if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<void> declineApplications({required List<int> ids}) async {
    try {
      final User? user = await _database.getUser();
      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Warehouse/declineApplication',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode({
        'applicationIds': ids,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

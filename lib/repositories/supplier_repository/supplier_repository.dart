import 'dart:convert';
import 'dart:developer';

import 'package:diploma_frontend/models/expiring_contracts.dart';
import 'package:diploma_frontend/models/supplier.dart';
import 'package:diploma_frontend/models/supply_condition.dart';
import 'package:diploma_frontend/models/supply_contract.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/repositories/supplier_repository/base_supplier_repository.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SupplierRepository implements BaseSupplierRepository {
  final Database _database;
  SupplierRepository(this._database);
  @override
  Future<int?> add({
    required String name,
    required String address,
    required String email,
    required String phoneNum,
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Supplier/add',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode({
        'name': name,
        'address': address,
        'email': email,
        'phoneNum': phoneNum,
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
  Future<int?> addcontract({
    required int supplierId,
    required DateTime startDate,
    required DateTime endDate,
    required int minAmount,
    required int maxAmount,
    required List<SupplyCondition> addSupplyConditions,
    required BuildContext context,
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Supplier/addcontract',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };
      final List<Map<String, dynamic>> conditions =
          addSupplyConditions.map((SupplyCondition e) {
        return e.newConditionsToJson();
      }).toList();

      final body = jsonEncode({
        'supplierId': supplierId,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'minAmount': minAmount,
        'maxAmount': maxAmount,
        'addSupplyConditions': conditions,
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
  Future<List<Supplier>?> all({
    required String name,
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Supplier/all?name=$name',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<Supplier>((json) {
          return Supplier.fromJson(json);
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
  Future<void> edit({
    required int id,
    required String name,
    required String address,
    required String email,
    required String phoneNum,
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Supplier/edit',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode({
        'id': id,
        'name': name,
        'address': address,
        'email': email,
        'phoneNum': phoneNum,
      });
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['id'];
      } else if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }
      return;
    } catch (e) {
      log(e.toString());
      return;
    }
  }

  @override
  Future<List<SupplyContract>?> supplierContracts({
    required bool old,
    String productName = '',
    String supplierName = '',
    String maker = '',
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Supplier/contracts?old=$old&productName=$productName&supplierName=$supplierName&maker=$maker',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<SupplyContract>((e) {
          return SupplyContract.fromJson(e);
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
  Future<List<ExpiringContract>?> expiringContracts({
    required int limit,
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Supplier/expiringContracts?limit=$limit',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<ExpiringContract>((e) {
          return ExpiringContract.fromJson(e);
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
}

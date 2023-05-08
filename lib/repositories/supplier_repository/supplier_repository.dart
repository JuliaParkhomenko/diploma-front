import 'dart:convert';
import 'dart:developer';

import 'package:diploma_frontend/models/supply_condition.dart';
import 'package:diploma_frontend/models/supply.dart';
import 'package:diploma_frontend/enums/action_status.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/repositories/supplier_repository/base_supplier_repository.dart';
import 'package:diploma_frontend/services/database/database.dart';
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
    required ActionStatus status,
    required DateTime startDate,
    required DateTime endDate,
    required int minAmount,
    required int maxAmount,
    required List<SupplyCondition> addSupplyConditions,
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

      final body = jsonEncode({
        'supplierId': supplierId,
        'status': status.getActionStatus(),
        'startDate': startDate,
        'endDate': endDate,
        'minAmount': minAmount,
        'maxAmount': maxAmount,
        'addSupplyConditions': addSupplyConditions.map((SupplyCondition e) {
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
  Future<List<Supply>?> all() async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Supplier/all',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<Supply>((json) {
          return Supply.fromJson(json);
        }).toList();
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

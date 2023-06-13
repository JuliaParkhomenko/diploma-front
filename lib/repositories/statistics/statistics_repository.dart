import 'dart:convert';
import 'dart:developer';

import 'package:diploma_frontend/models/optimization.dart';
import 'package:diploma_frontend/models/requests/opt_request.dart';
import 'package:diploma_frontend/models/statistics.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/repositories/statistics/base_statistics_repository.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:http/http.dart' as http;

class StatisticsRepository implements BaseStatisticsRepository {
  final Database _database;
  StatisticsRepository(this._database);

  @override
  Future<List<Statistics>?> product({required int warehouseId}) async {
    try {
      final User? user = await _database.getUser();

      final Uri uri = Uri.parse(
          'https://restaurant-warehouse.azurewebsites.net/api/Statistics/general?WarehouseId=$warehouseId');

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data.map<Statistics>((e) {
          return Statistics.fromJson(e);
        }).toList();
      }
      if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Optimization>?> optimization({
    required List<OptRequest> opt,
  }) async {
    try {
      final User? user = await _database.getUser();
      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Optimization',
      );
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode(opt.map((e) {
        return e.toJson();
      }).toList());

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<Optimization>((e) {
          return Optimization.fromJson(e);
        }).toList();
      } else if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }
      return null;
    } catch (error) {
      log(error.toString());
      return null;
    }
  }
}

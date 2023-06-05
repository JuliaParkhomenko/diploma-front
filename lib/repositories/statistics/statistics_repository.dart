import 'dart:convert';

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
  Future<Statistics?> product({
    int? warehouseId,
    int? productId,
    DateTime? dateFrom,
    DateTime? dateTo,
    bool? ordered,
    bool? used,
    bool? writtenOff,
  }) async {
    try {
      final User? user = await _database.getUser();
      String url =
          'https://restaurant-warehouse.azurewebsites.net/api/Statistics/product?';
      /*if (warehouseId != null) {
        url += 'WarehouseId=$warehouseId';
      }
      if (productId != null) {
        url += '&ProductId=$productId';
      }
      if (dateFrom != null) {
        url += '&DateFrom=$dateFrom';
      }
      if (dateTo != null) {
        url += '&DateTo=$dateTo';
      }
      if (ordered != null) {
        url += '&Ordered=$ordered';
      }
      if (used != null) {
        url += '&Used=$used';
      }
      if (writtenOff != null) {
        url += '&WrittenOff=$writtenOff';
      }*/
      url +=
          'WarehouseId=3&ProductId=1&DateFrom=05-05-2020&DateTo=05-07-2023&Ordered=true&Used=true&WrittenOff=true';
      final Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.post(uri, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Statistics.fromJson(data);
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
}

import 'dart:convert';
import 'dart:developer';
import 'package:diploma_frontend/models/batch.dart';
import 'package:diploma_frontend/models/batch_supply.dart';
import 'package:diploma_frontend/models/expiring_batch.dart';
import 'package:diploma_frontend/models/ordered_batch.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/repositories/batch_repository/base_batch_repository.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:http/http.dart' as http;

class BatchRepository implements BaseBatchRepository {
  final Database _database;
  BatchRepository(this._database);
  @override
  Future<List<Batch>?> forStock({
    required int id,
    String batchId = '',
    String kind = '',
    String maker = '',
    String status = '',
  }) async {
    try {
      final User? user = await _database.getUser();

      String url =
          'https://restaurant-warehouse.azurewebsites.net/api/Batch/forStock?stockId=$id';

      if (batchId != '') {
        url += '&batchId=$batchId';
      }

      if (kind != '') {
        url += '&kind=$kind';
      }

      if (maker != '') {
        url += '&maker=$maker';
      }

      if (status != '') {
        url += '&status=$status';
      }

      final Uri uri = Uri.parse(url);

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<Batch>((e) {
          return Batch.fromJson(e);
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
  Future<int?> receiveBatch({
    required int batchId,
    required DateTime productionTime,
    required DateTime expirationTime,
    required int notificationDate,
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch/receive',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode({
        'batchId': batchId,
        'productionDate': productionTime.toString(),
        'expirationDate': expirationTime.toString(),
        'notificationDate': notificationDate,
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
    } catch (_) {
      log(_.toString());
      return null;
    }
  }

  @override
  Future<Batch?> getBatch({required int id}) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch?batchId=$id',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Batch.fromJson(data);
      } else if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }

      return null;
    } catch (_) {
      log(_.toString());
      return null;
    }
  }

  @override
  Future<void> useBatch({required int id, required int amount}) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch/use',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode({'batchId': id, 'amount': amount});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }
    } catch (_) {
      log(_.toString());
    }
  }

  @override
  Future<void> writeOffAll({required int id}) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch/writeOff?batchId=$id',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 401) {
        await ServiceLocator.database.clear();
        await ServiceLocator.appStateService.logIn();
      }
    } catch (_) {
      log(_.toString());
    }
  }

  @override
  Future<List<OrderedBatch>?> orderedBatches({
    required int warehouseId,
    required String productName,
    required String batchId,
    required String kind,
  }) async {
    try {
      final User? user = await _database.getUser();

      String url =
          'https://restaurant-warehouse.azurewebsites.net/api/Batch/orderedBatches?warehouseId=$warehouseId';

      if (productName != '') {
        url += '&productName=$productName';
      }

      if (batchId != '') {
        url += '&batchId=$batchId';
      }

      if (kind != '') {
        url += '&kind=$kind';
      }

      final Uri uri = Uri.parse(url);

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<OrderedBatch>((e) {
          return OrderedBatch.fromJson(e);
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
  Future<List<ExpiringBatch>?> expiringBatches({
    required int warehouseId,
    required int amount,
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch/expiringBatches?warehouseId=$warehouseId&amount=$amount',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<ExpiringBatch>((e) {
          return ExpiringBatch.fromJson(e);
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
  Future<List<ExpiringBatch>?> expiredBatches({
    required int warehouseId,
    required int amount,
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch/expiredBatches?warehouseId=$warehouseId&amount=$amount',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<ExpiringBatch>((e) {
          return ExpiringBatch.fromJson(e);
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
  Future<List<BatchSupply>?> getSupplies({
    String productName = '',
    String warehouseName = '',
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch/getSupplies?warehouseName=$warehouseName&productName=$productName',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<BatchSupply>((e) {
          return BatchSupply.fromJson(e);
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
